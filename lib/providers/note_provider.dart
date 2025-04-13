import 'package:flutter/material.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/service/note_service.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];
  final Uuid _uuid = Uuid();
  final NoteService _noteService = NoteService();
  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    final fetchedNotes = await _noteService.fetchNote();
    _notes.clear();
    _notes.addAll(fetchedNotes);
    notifyListeners();
  }

  void addNote(
    String title,
    String description,
    DateTime date,
    String priority,
  ) {
    final newNote = Note(
      id: _uuid.v4(),
      title: title,
      description: description,
      date: date,
      priority: priority,
      section: "In Progress",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _notes.add(newNote);
    _noteService.createNote(newNote);
    notifyListeners();
  }

  void editNote(
    String id,
    String title,
    String description,
    DateTime date,
    String priority,
  ) {
    final noteIndex = notes.indexWhere((note) => note.id == id);
    if (noteIndex != 1) {
      final updatedNote = Note(
        id: id,
        title: title,
        description: description,
        date: date,
        priority: priority,
        section: "In Progress",
        createdAt: notes[noteIndex].createdAt,
        updatedAt: DateTime.now(),
      );

      _notes[noteIndex] = updatedNote;
      _noteService.editNote(updatedNote);
      notifyListeners();
    }
  }

  void updateNoteSection(String id) {
    final noteIndex = notes.indexWhere((note) => note.id == id);
    if (noteIndex != 1) {
      final updateNote = Note(
        id: id,
        title: notes[noteIndex].title,
        description: notes[noteIndex].description,
        date: notes[noteIndex].date,
        priority: notes[noteIndex].priority,
        section: "Completed",
        createdAt: notes[noteIndex].createdAt,
        updatedAt: DateTime.now(),
      );

      _notes[noteIndex] = updateNote;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    _noteService.deleteNote(id);
    notifyListeners();
  }

  Note findByID(String id) {
    return notes.firstWhere((note) => note.id == id);
  }

  List<Note> findByPriority(String priority) {
    return notes.where((note) => note.priority == priority).toList();
  }

  List<Note> findByTitle(String title) {
    return notes
        .where((note) => note.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
