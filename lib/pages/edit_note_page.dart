import 'package:flutter/material.dart';
import 'package:taskhub_app/templates/note_form_template.dart';

class EditNotePage extends StatelessWidget {
  static const routeName = "/edit-note";
  const EditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NoteForm(option: "edit");
  }
}
