import 'package:flutter/material.dart';
import 'package:taskhub_app/templates/detail_note_template.dart';
import 'package:provider/provider.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/pages/edit_note_page.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/widgets/notification/alert.dart';
import 'package:taskhub_app/widgets/popup/action_popup.dart';

class DetailNotePage extends StatefulWidget {
  static const routeName = "/detail-note";
  const DetailNotePage({super.key});

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  String action = "view";

  @override
  Widget build(BuildContext context) {
    final passedNote = ModalRoute.of(context)!.settings.arguments as Note;
    late Note note;

    if (action == "view") {
      note = context.watch<NoteProvider>().findByID(passedNote.id);
    } else {
      note = passedNote;
    }

    void actionHandle(String option) {
      if (option == "edit") {
        Navigator.pushReplacementNamed(
          context,
          EditNotePage.routeName,
          arguments: note,
        );
      }

      if (option == "update" || option == "delete") {
        if (option == "update") {
          context.read<NoteProvider>().updateNoteSection(note.id);
          setState(() {
            action = "view";
          });
        }

        if (option == "delete") {
          context.read<NoteProvider>().deleteNote(note.id);
          setState(() {
            action = "delete";
          });
          Navigator.pop(context);
        }

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 1),
            elevation: 0,
            content: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: option == "update" ? 10 : 40,
              ),
              child: Alert(
                icon: Icons.done_rounded,
                colorAlert: Color.fromARGB(1000, 63, 125, 88),
                message: option == "update"
                    ? "Successfully marked as completed"
                    : "Successfully delete note",
              ),
            ),
          ),
        );
      }
    }

    final List<ActionButton> actionButton = [
      ActionButton(
        title: "Mark as Completed",
        icon: Icons.check_circle_outline_rounded,
        function: () => actionHandle("update"),
      ),
      ActionButton(
        title: "Edit Note",
        icon: Icons.check_circle_outline_rounded,
        function: () => actionHandle("edit"),
      ),
      ActionButton(
        title: "Delete Note",
        icon: Icons.delete_forever_outlined,
        function: () => actionHandle("delete"),
      ),
    ];

    return DetailNoteTemplate(actionButton: actionButton, data: note);
  }
}
