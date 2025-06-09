import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animations/animations.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/widgets/card/note_card.dart';

class NoteTabbar extends StatelessWidget {
  final bool isSearch;
  final List<Note> notes;
  final int selectedTabIndex;

  const NoteTabbar({
    super.key,
    required this.isSearch,
    required this.notes,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: isSearch ? 5 : 20,
          ),
          child: PageTransitionSwitcher(
            transitionBuilder: (child, animation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                fillColor: Colors.transparent,
                child: child,
              );
            },
            child: _buildTabContent(state),
          ),
        );
      },
    );
  }

  Widget _buildTabContent(NoteState state) {
    if (state is NoteLoaded) {
      final notes = state.notes;

      if (isSearch) {
        return _buildNoteList(notes, "0");
      }

      List<Note> filteredNotes;
      switch (selectedTabIndex) {
        case 0:
          filteredNotes = notes;
        case 1:
          filteredNotes =
              notes.where((note) => note.priority == "High").toList();
          break;
        case 2:
          filteredNotes =
              notes.where((note) => note.priority == "Medium").toList();
          break;
        case 3:
          filteredNotes =
              notes.where((note) => note.priority == "Low").toList();
          break;
        default:
          filteredNotes = [];
      }
      return _buildNoteList(filteredNotes, selectedTabIndex.toString());
    }
    return Center(child: CircularProgressIndicator());
  }
}

Widget _buildNoteList(List<Note> notes, String value) {
  return ListView.separated(
    key: ValueKey(value),
    itemBuilder: (context, index) {
      final note = notes[index];
      return NoteCard(note: note);
    },
    separatorBuilder: (context, index) {
      return Divider(
        height: 12,
        color: Color.fromRGBO(248, 244, 244, 1.0),
      );
    },
    itemCount: notes.length,
  );
}
