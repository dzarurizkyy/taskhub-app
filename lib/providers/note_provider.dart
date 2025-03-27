import 'package:flutter/material.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [
    Note(
      id: "53d68788-780c-4215-930f-237a1da4a29a",
      title: "This is title",
      description: "This is description",
      date: DateTime.parse("2025-03-25 03:00:00"),
      priority: "High",
      createdAt: DateTime.parse("2025-03-24 03:00:00"),
      updatedAt: DateTime.parse("2025-03-24 03:00:00"),
    ),
    Note(
      id: "53d68788-780c-4215-930f-237a1da4a29a",
      title: "This is title",
      description: "This is description",
      date: DateTime.parse("2025-03-25 03:00:00"),
      priority: "Medium",
      createdAt: DateTime.parse("2025-03-24 03:00:00"),
      updatedAt: DateTime.parse("2025-03-24 03:00:00"),
    ),
    Note(
      id: "53d68788-780c-4215-930f-237a1da4a29a",
      title: "This is title",
      description: "This is description",
      date: DateTime.parse("2025-03-25 03:00:00"),
      priority: "Low",
      createdAt: DateTime.parse("2025-03-24 03:00:00"),
      updatedAt: DateTime.parse("2025-03-24 03:00:00"),
    ),
  ];
  final Uuid _uuid = Uuid();

  List<Note> get notes => _notes;
  int get totalNote => notes.length;

  List<Note> findByPriority(String priority) {
    final filteredNotes =
        _notes.where((note) => note.priority == priority).toList();

    return filteredNotes;
  }

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
