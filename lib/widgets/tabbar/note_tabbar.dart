import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/widgets/card/note_card.dart';

class NoteTabbar extends StatefulWidget {
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
  State<NoteTabbar> createState() => _NoteTabbarState();
}

class _NoteTabbarState extends State<NoteTabbar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: widget.isSearch ? 5 : 20,
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
            child: _buildTabContent(provider, widget.isSearch),
          ),
        );
      },
    );
  }

  Widget _buildTabContent(NoteProvider provider, bool isSearch) {
    if (isSearch) {
      return _buildNoteList(widget.notes, "0");
    } else {
      switch (widget.selectedTabIndex) {
        case 0:
          return _buildNoteList(
              provider.notes, widget.selectedTabIndex.toString());
        case 1:
          return _buildNoteList(provider.findByPriority("High"),
              widget.selectedTabIndex.toString());
        case 2:
          return _buildNoteList(provider.findByPriority("Medium"),
              widget.selectedTabIndex.toString());
        case 3:
          return _buildNoteList(provider.findByPriority("Low"),
              widget.selectedTabIndex.toString());
        default:
          return Container();
      }
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
}
