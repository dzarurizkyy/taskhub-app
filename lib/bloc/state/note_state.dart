import 'package:taskhub_app/models/note.dart';

abstract class NoteState {
  const NoteState();
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;
  const NoteLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;
  const NoteError(this.message);
}
