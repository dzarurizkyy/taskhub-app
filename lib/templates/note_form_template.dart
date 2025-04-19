import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:taskhub_app/helpers/datetime.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/widgets/button/select_button.dart';
import 'package:taskhub_app/widgets/button/submit_button.dart';
import 'package:taskhub_app/widgets/header/note_form_header.dart';
import 'package:taskhub_app/widgets/input/input_date.dart';
import 'package:taskhub_app/widgets/input/input_description.dart';
import 'package:taskhub_app/widgets/input/input_title.dart';
import 'package:taskhub_app/models/note.dart';

class NoteForm extends StatefulWidget {
  final String option;
  const NoteForm({super.key, required this.option});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  late bool isButtonEnabled = false;

  late String _priority = "High";
  final List<String> _priorities = ["High", "Medium", "Low"];

  void _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );

    if (picked != null) {
      _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void _pickTime(BuildContext context) async {
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
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  bool _attemptNote() {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final sanitizeText = HtmlUnescape();
    final date = combineDateTime(_dateController.text, _timeController.text);

    try {
      if (widget.option == "edit") {
        final note = ModalRoute.of(context)!.settings.arguments as Note;
        noteProvider.editNote(
          note.id,
          sanitizeText.convert(_titleController.text),
          sanitizeText.convert(_descriptionController.text),
          date,
          _priority,
        );
      } else {
        noteProvider.addNote(
          sanitizeText.convert(_titleController.text),
          sanitizeText.convert(_descriptionController.text),
          date,
          _priority,
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onInputChanged);
    _descriptionController.addListener(_onInputChanged);
    _dateController.addListener(_onInputChanged);
    _timeController.addListener(_onInputChanged);

    Future.microtask(() {
      if (widget.option == "edit") {
        final note = ModalRoute.of(context)!.settings.arguments as Note;

        _titleController.text = note.title;
        _descriptionController.text = note.description;

        final dateTime = note.date;
        _dateController.text =
            "${dateTime.day}/${dateTime.month}/${dateTime.year}";
        _timeController.text =
            "${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}";

        _priority = note.priority;
      }
    });
  }

  void _onInputChanged() {
    setState(() {
      isButtonEnabled = _titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _dateController.text.isNotEmpty &&
          _timeController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoteFormHeader(
        title: widget.option == "add" ? "Add Note" : "Edit Note",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Wrap(
            runSpacing: 15,
            children: [
              Form(
                key: formkey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1.000),
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
                          InputTitle(
                            title: "Task Name",
                            hint: "Enter task title",
                            controller: _titleController,
                          ),
                          InputDescription(
                            title: "Description",
                            hint: "Describe your task",
                            controller: _descriptionController,
                          ),
                          Row(
                            children: List.generate(3, (index) {
                              if (index == 1) {
                                return SizedBox(width: 15);
                              }

                              return InputDate(
                                title: index == 0 ? "Due Date" : "Due Time",
                                hint: index == 0 ? "DD/MM/YY" : "HH:MM",
                                controller: index == 0
                                    ? _dateController
                                    : _timeController,
                                picker: () => index == 0
                                    ? _pickDate(context)
                                    : _pickTime(context),
                              );
                            }),
                          ),
                          SelectButton(
                            title: "Priority",
                            choice: _priorities,
                            priority: _priority,
                            selected: (value) {
                              setState(() {
                                _priority = value;
                              });
                            },
                          ),
                          SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 15),
                            width: double.infinity,
                            child: SubmitButton(
                              formkey: formkey,
                              isButtonEnabled: isButtonEnabled,
                              title: widget.option == "add"
                                  ? "Add Note"
                                  : "Edit Note",
                              titleBold: FontWeight.w800,
                              successMessage: widget.option == "add"
                                  ? "Your note has been saved"
                                  : "Your note has been updated",
                              failedMessage: widget.option == "add"
                                  ? "Failed to add note. Please try again"
                                  : "Failed to edit note. Please try again",
                              successPadding: widget.option == "add" ? 40 : 30,
                              failedPadding: 30,
                              validation: () async {
                                _attemptNote;
                                return true;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(252, 250, 250, 1),
    );
  }
}
