import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/class/note_screen_bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/bloc/event/note_screen_event.dart';
import 'package:taskhub_app/bloc/state/note_screen_state.dart';
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

  final List<String> _priorities = ["High", "Medium", "Low"];

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, 12, 31));
    if (picked != null) {
      _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
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
      _timeController.text = picked.format(context);
    }
  }

  bool _submit(BuildContext context) {
    final sanitizeText = HtmlUnescape();
    final date = combineDateTime(_dateController.text, _timeController.text);

    try {
      if (option == "edit") {
        final note = ModalRoute.of(context)!.settings.arguments as Note;
        context.read<NoteBloc>().add(
              EditNote(
                note.id,
                sanitizeText.convert(_titleController.text),
                sanitizeText.convert(_descriptionController.text),
                date,
                (context.read<NoteScreenBloc>().state as NoteScreenLoaded)
                    .priority,
                note.section,
                note.updatedAt,
                DateTime.now(),
              ),
            );
      } else {
        context.read<NoteBloc>().add(
              AddNote(
                sanitizeText.convert(_titleController.text),
                sanitizeText.convert(_descriptionController.text),
                date,
                (context.read<NoteScreenBloc>().state as NoteScreenLoaded)
                    .priority,
              ),
            );
        context.read<NoteScreenBloc>().add(ChangeButtonStatus("", "", "", ""));
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
    if (isEdit) {
      final note = ModalRoute.of(context)!.settings.arguments as Note;
      context.read<NoteScreenBloc>().add(ChangePriority(note.priority));
      _titleController.text = note.title;
      _descriptionController.text = note.description;
      _dateController.text =
          "${note.date.day}/${note.date.month}/${note.date.year}";
      _timeController.text =
          "${note.date.hour.toString().padLeft(2, '0')}:${note.date.minute.toString().padLeft(2, '0')}";
    }

    _titleController.addListener(() {
      context.read<NoteScreenBloc>().add(
            ChangeButtonStatus(
              _titleController.text,
              _descriptionController.text,
              _dateController.text,
              _timeController.text,
            ),
          );
    });

    _descriptionController.addListener(() {
      context.read<NoteScreenBloc>().add(
            ChangeButtonStatus(
              _titleController.text,
              _descriptionController.text,
              _dateController.text,
              _timeController.text,
            ),
          );
    });

    _dateController.addListener(() {
      context.read<NoteScreenBloc>().add(
            ChangeButtonStatus(
              _titleController.text,
              _descriptionController.text,
              _dateController.text,
              _timeController.text,
            ),
          );
    });

    _timeController.addListener(() {
      context.read<NoteScreenBloc>().add(
            ChangeButtonStatus(
              _titleController.text,
              _descriptionController.text,
              _dateController.text,
              _timeController.text,
            ),
          );
    });

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
              Form(
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
                              Expanded(
                                child: DateNoteformInput(
                                  title: "Due Date",
                                  hint: "DD/MM/YY",
                                  controller: _dateController,
                                  picker: () => _pickDate(context),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: DateNoteformInput(
                                  title: "Due Time",
                                  hint: "HH:MM",
                                  controller: _timeController,
                                  picker: () => _pickTime(context),
                                ),
                              )
                            ],
                          ),
                          BlocBuilder<NoteScreenBloc, NoteScreenState>(
                            builder: (context, state) {
                              if (state is NoteScreenLoaded) {
                                return SelectButton(
                                  type: "note_form",
                                  title: "Priority",
                                  choice: _priorities,
                                  priority: state.priority,
                                  selected: (value) {
                                    context.read<NoteScreenBloc>().add(
                                          ChangePriority(value),
                                        );
                                  },
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 15),
                            width: double.infinity,
                            child: BlocBuilder<NoteScreenBloc, NoteScreenState>(
                              builder: (context, state) {
                                if (state is NoteScreenLoaded) {
                                  return SubmitButton(
                                    formkey: _formKey,
                                    title: isEdit ? "Edit Note" : "Add Note",
                                    titleBold: FontWeight.w800,
                                    isButtonEnabled: state.buttonStatus,
                                    successMessage: isEdit
                                        ? "Your note has been updated"
                                        : "Your note has been saved",
                                    failedMessage: isEdit
                                        ? "Failed to edit note. Please try again"
                                        : "Failed to add note. Please try again",
                                    successPadding: isEdit ? 30 : 40,
                                    failedPadding: 30,
                                    validation: () async {
                                      return _submit(context);
                                    },
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(252, 250, 250, 1),
    );
  }
}
