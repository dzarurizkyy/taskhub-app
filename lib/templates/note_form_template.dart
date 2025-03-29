import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:taskhub_app/helpers/datetime.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/widgets/button/select_button.dart';
import 'package:taskhub_app/widgets/card/note_card.dart';
import 'package:taskhub_app/widgets/header/note_form_header.dart';
import 'package:taskhub_app/widgets/input/input_date.dart';
import 'package:taskhub_app/widgets/input/input_description.dart';
import 'package:taskhub_app/widgets/input/input_title.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({super.key});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late String _priority = "High";
  final List<String> _priorities = ["High", "Medium", "Low"];
  late bool _isAttempt = false;

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

  void _attemptNote() {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final sanitizeText = HtmlUnescape();
    final date = combineDateTime(_dateController.text, _timeController.text);

    noteProvider.addNote(
      sanitizeText.convert(_titleController.text),
      sanitizeText.convert(_descriptionController.text),
      date,
      _priority,
    );

    setState(() {
      _isAttempt = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: NoteFormHeader(title: "Add Task"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                              selected: (value) {
                                setState(() {
                                  _priority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<NoteProvider>(
                  builder: (context, noteProvider, child) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final note = noteProvider.notes[index];
                        return NoteCard(
                          title: note.title,
                          description: note.description,
                          priority: note.priority,
                          day:
                              DateFormat("EEE").format(note.date).toUpperCase(),
                          date: DateFormat("d").format(note.date),
                          time: DateFormat("HH:mm").format(note.date),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Color.fromRGBO(248, 244, 244, 1.0),
                          height: 15,
                        );
                      },
                      itemCount: noteProvider.totalNote,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            _attemptNote();

            Future.delayed(Duration(seconds: 5), () {
              setState(() {
                _isAttempt = false;
              });
            });
          },
          elevation: 0,
          backgroundColor: _isAttempt
              ? Color.fromRGBO(79, 197, 135, 1.000)
              : Color.fromRGBO(53, 182, 215, 1.000),
          child: Icon(
            _isAttempt ? Icons.done : Icons.add_rounded,
            color: Color.fromRGBO(255, 255, 255, 1.0),
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Color.fromRGBO(248, 244, 244, 1.0),
      ),
    );
  }
}
