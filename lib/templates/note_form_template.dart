import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/helpers/datetime.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/widgets/button/select_button.dart';
import 'package:taskhub_app/widgets/button/submit_button.dart';
import 'package:taskhub_app/widgets/header/note_form_header.dart';
import 'package:taskhub_app/widgets/input/noteform_date_input.dart';
import 'package:taskhub_app/widgets/input/noteform_description_input.dart';
import 'package:taskhub_app/widgets/input/noteform_title_input.dart';

class NoteForm extends StatelessWidget {
  final String option;
  NoteForm({super.key, required this.option});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);
  final ValueNotifier<String> defaultPriority = ValueNotifier("High");
  final ValueNotifier<String> defaultDate = ValueNotifier(
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
  final ValueNotifier<String> defaultTime = ValueNotifier(
      "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}");

  final List<String> _priorities = ["High", "Medium", "Low"];

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, 12, 31));
    if (picked != null) {
      defaultDate.value = "${picked.day}/${picked.month}/${picked.year}";
      _dateController.text = defaultDate.value;
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (!context.mounted) return;
      defaultTime.value =
          "${picked.hour.toString().padLeft(2, "0")}:${picked.minute.toString().padLeft(2, "0")}";
      _timeController.text = defaultTime.value;
    }
  }

  bool _submit(BuildContext context) {
    final sanitizeText = HtmlUnescape();
    final date = combineDateTime(defaultDate.value, defaultTime.value);

    try {
      if (option == "edit") {
        final note = ModalRoute.of(context)!.settings.arguments as Note;
        context.read<NoteBloc>().add(
              EditNote(
                note.id,
                sanitizeText.convert(_titleController.text),
                sanitizeText.convert(_descriptionController.text),
                date,
                defaultPriority.value,
                note.section,
                note.updatedAt,
                DateTime.now(),
              ),
            );
        Navigator.of(context).pop();
      } else {
        context.read<NoteBloc>().add(
              AddNote(
                  sanitizeText.convert(_titleController.text),
                  sanitizeText.convert(_descriptionController.text),
                  date,
                  defaultPriority.value),
            );
      }
      Navigator.of(context).pop();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = option == "edit";

    void validateForm() {
      isButtonEnabled.value = _titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _dateController.text.isNotEmpty &&
          _timeController.text.isNotEmpty;
    }

    _titleController.addListener(validateForm);
    _descriptionController.addListener(validateForm);
    _dateController.addListener(validateForm);
    _timeController.addListener(validateForm);

    return Scaffold(
      appBar: NoteFormHeader(title: isEdit ? "Edit Note" : "Add Note"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 25,
          ),
          child: Wrap(
            runSpacing: 15,
            children: [
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteLoadedById || state is NoteLoaded) {
                    if (option == "edit" && state is NoteLoadedById) {
                      _titleController.text = state.note.title;
                      _descriptionController.text = state.note.description;
                      _dateController.text =
                          "${state.note.date.day}/${state.note.date.month}/${state.note.date.year}";
                      _timeController.text =
                          "${state.note.date.hour.toString().padLeft(2, "0")}:${state.note.date.minute.toString().padLeft(2, "0")}";
                    }

                    return Form(
                      key: _formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(17, 17, 26, 0.05),
                                offset: Offset(0, 1),
                                blurRadius: 0,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(17, 17, 26, 0.1),
                                offset: Offset(0, 0),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Wrap(
                              runSpacing: 15,
                              children: [
                                TitleNoteFormInput(
                                  title: "Task Name",
                                  hint: "Enter task title",
                                  controller: _titleController,
                                ),
                                DescriptionNoteFormInput(
                                  title: "Description",
                                  hint: "Describe your task",
                                  controller: _descriptionController,
                                ),
                                Row(
                                  children: [
                                    ValueListenableBuilder<String>(
                                      valueListenable: defaultDate,
                                      builder: (context, value, child) {
                                        return Expanded(
                                          child: DateNoteformInput(
                                            title: "Due Date",
                                            hint: "DD/MM/YY",
                                            controller: _dateController,
                                            picker: () => _pickDate(context),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 15),
                                    ValueListenableBuilder<String>(
                                      valueListenable: defaultTime,
                                      builder: (context, value, child) {
                                        return Expanded(
                                          child: DateNoteformInput(
                                            title: "Due Time",
                                            hint: "HH:MM",
                                            controller: _timeController,
                                            picker: () => _pickTime(context),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                ValueListenableBuilder<String>(
                                  valueListenable: defaultPriority,
                                  builder: (context, currentPriority, _) {
                                    return SelectButton(
                                      type: "note_form",
                                      title: "Priority",
                                      choice: _priorities,
                                      priority: defaultPriority.value,
                                      selected: (value) {
                                        defaultPriority.value = value;
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 40),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  width: double.infinity,
                                  child: ValueListenableBuilder<bool>(
                                    valueListenable: isButtonEnabled,
                                    builder: (context, validation, _) {
                                      return SubmitButton(
                                        formkey: _formKey,
                                        title:
                                            isEdit ? "Edit Note" : "Add Note",
                                        titleBold: FontWeight.w800,
                                        isButtonEnabled: validation,
                                        successMessage: isEdit
                                            ? "Your note has been updated"
                                            : "Your note has been saved",
                                        failedMessage: isEdit
                                            ? "Failed to edit note. Please try again"
                                            : "Failed to add note. Please try again",
                                        successPadding: isEdit ? 30 : 40,
                                        failedPadding: 30,
                                        fontSizeNotification: 12,
                                        validation: () async {
                                          return _submit(context);
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text("$state");
                  }
                },
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(252, 250, 250, 1),
    );
  }
}
