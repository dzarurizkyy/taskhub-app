import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/pages/edit_note_page.dart';
import 'package:taskhub_app/widgets/notification/alert.dart';
import 'package:taskhub_app/widgets/popup/action_popup.dart';
import 'package:taskhub_app/templates/detail_note_template.dart';

class DetailNotePage extends StatelessWidget {
  static const routeName = "/detail-note";
  const DetailNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final passedNote = ModalRoute.of(context)!.settings.arguments as Note;

    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(milliseconds: 1500),
          elevation: 0,
          content: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: message.contains("delete") ? 40 : 10,
            ),
            child: Alert(
              icon: Icons.done_rounded,
              colorAlert: const Color.fromRGBO(63, 125, 88, 1.0),
              message: message,
            ),
          ),
        ),
      );
    }

    void actionHandle(String option, Note? note) async {
      final bloc = context.read<NoteBloc>();

      switch (option) {
        case "edit":
          Navigator.of(context).pushNamed(
            EditNotePage.routeName,
            arguments: note,
          );
          break;
        case "update":
          bloc.add(UpdateNote(note!.id));

          await Future.delayed(Duration(milliseconds: 550));
          if (!context.mounted) return;

          Navigator.pop(context);
          showSnackBar("Successfully marked as completed");
          break;
        case "delete":
          bloc.add(DeleteNote(note!.id));

          await Future.delayed(Duration(milliseconds: 550));
          if (!context.mounted) return;

          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar("Successfully delete note");
          break;
      }
    }

    final List<ActionButton> actionButton = [
      ActionButton(
        title: "Mark as Completed",
        icon: Icons.check_circle_outline_rounded,
        function: () => actionHandle("update", passedNote),
      ),
      ActionButton(
        title: "Edit Note",
        icon: Icons.edit_outlined,
        function: () => actionHandle("edit", passedNote),
      ),
      ActionButton(
        title: "Delete Note",
        icon: Icons.delete_forever_outlined,
        function: () => actionHandle("delete", passedNote),
      )
    ];

    return DetailNoteTemplate(
      actionButton: actionButton,
      data: passedNote,
    );
  }
}
