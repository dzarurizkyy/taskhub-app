import 'package:flutter/material.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [
    Note(
      id: "1a2b3c4d-1234-5678-9101-abcdef123456",
      title: "Daily Standup Meeting",
      description: "Discuss project progress with the team.",
      date: DateTime.parse("2025-03-28 09:00:00"),
      priority: "High",
      createdAt: DateTime.parse("2025-03-28 07:30:00"),
      updatedAt: DateTime.parse("2025-03-28 07:30:00"),
    ),
    Note(
      id: "2b3c4d5e-2345-6789-0123-bcdef2345678",
      title: "Code Review PR #42",
      description: "Check the latest pull request and give feedback.",
      date: DateTime.parse("2025-03-29 14:00:00"),
      priority: "Medium",
      createdAt: DateTime.parse("2025-03-28 10:15:00"),
      updatedAt: DateTime.parse("2025-03-28 10:15:00"),
    ),
    Note(
      id: "3c4d5e6f-3456-7890-1234-cdef34567890",
      title: "Doctor Appointment",
      description: "Routine check-up with Dr. Adam.",
      date: DateTime.parse("2025-03-30 11:30:00"),
      priority: "Low",
      createdAt: DateTime.parse("2025-03-28 12:00:00"),
      updatedAt: DateTime.parse("2025-03-28 12:00:00"),
    ),
    Note(
      id: "4d5e6f7g-4567-8901-2345-def456789012",
      title: "Grocery Shopping",
      description: "Buy vegetables, chicken, and coffee for the week.",
      date: DateTime.parse("2025-03-31 17:30:00"),
      priority: "Medium",
      createdAt: DateTime.parse("2025-03-28 13:45:00"),
      updatedAt: DateTime.parse("2025-03-28 13:45:00"),
    ),
    Note(
      id: "5e6f7g8h-5678-9012-3456-ef5678901234",
      title: "Gym Workout",
      description: "Focus on strength training and cardio.",
      date: DateTime.parse("2025-04-01 07:00:00"),
      priority: "High",
      createdAt: DateTime.parse("2025-03-28 15:00:00"),
      updatedAt: DateTime.parse("2025-03-28 15:00:00"),
    ),
    Note(
      id: "6f7g8h9i-6789-0123-4567-f67890123456",
      title: "Flutter Learning Session",
      description: "Explore Flutter state management with Provider.",
      date: DateTime.parse("2025-04-02 20:00:00"),
      priority: "Low",
      createdAt: DateTime.parse("2025-03-28 16:30:00"),
      updatedAt: DateTime.parse("2025-03-28 16:30:00"),
    ),
  ];

  final Uuid _uuid = Uuid();

  List<Note> get notes => _notes;
  int get totalNote => notes.length;

  List<Note> findByPriority(String priority) {
    final filteredNotes =
        notes.where((note) => note.priority == priority).toList();

    return filteredNotes;
  }

  List<Note> findByTitle(String title) {
    final filteredNotes = notes
        .where((note) => note.title.toLowerCase().contains(title.toLowerCase()))
        .toList();

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
