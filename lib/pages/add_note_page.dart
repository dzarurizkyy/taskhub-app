import 'package:flutter/material.dart';
import 'package:taskhub_app/templates/note_form_template.dart';

class AddNotePage extends StatelessWidget {
  static const routeName = "/add-note";
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NoteForm(option: "add");
  }
}
