import 'package:flutter/material.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> notes = [];
  final Uuid _uuid = Uuid();

  int get totalNote => notes.length;

  void addNote(
    String title,
    String description,
    DateTime date,
    String priority,
  ) {
    notes.add(
      Note(
        id: _uuid.v4(),
        title: title,
        description: description,
        date: date,
        priority: priority,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
