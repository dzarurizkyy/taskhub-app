import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/pages/edit_note_page.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/widgets/notification/alert.dart';
import 'package:taskhub_app/widgets/popup/action_popup.dart';
import 'package:taskhub_app/templates/detail_note_template.dart';

class DetailNotePage extends StatelessWidget {
  static const routeName = "/detail-note";
  const DetailNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context)!.settings.arguments as String;

    Future.microtask(() {
      if (!context.mounted) return;
      context.read<NoteBloc>().add(FetchNoteById(noteId));
    });

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
              fontSizeNotification: 12,
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

          showSnackBar("Successfully marked as completed");

          Navigator.pop(context);
          break;
        case "delete":
          bloc.add(DeleteNote(note!.id));

          await Future.delayed(Duration(milliseconds: 550));
          if (!context.mounted) return;

          showSnackBar("Successfully delete note");

          Navigator.pushReplacementNamed(context, HomePage.routeName);
          break;
      }
    }

    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(1000, 32, 180, 224),
              ),
            ),
            backgroundColor: const Color.fromRGBO(252, 250, 250, 1),
          );
        } else if (state is NoteLoadedById) {
          final note = state.note;

          final List<ActionButton> actionButton = [
            ActionButton(
              title: "Mark as Completed",
              icon: Icons.check_circle_outline_rounded,
              function: () => actionHandle("update", note),
            ),
            ActionButton(
              title: "Edit Note",
              icon: Icons.edit_outlined,
              function: () => actionHandle("edit", note),
            ),
            ActionButton(
              title: "Delete Note",
              icon: Icons.delete_forever_outlined,
              function: () => actionHandle("delete", note),
            )
          ];

          return DetailNoteTemplate(
            actionButton: actionButton,
            data: note,
          );
        } else if (state is NoteError) {
          return Text(state.message);
        } else {
          return Text("Hello $state");
        }
      },
    );
  }
}
