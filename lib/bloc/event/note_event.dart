import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  const AddNote(this.title, this.description, this.date, this.priority);

  @override
  List<Object> get props => [title, description, date, priority];
}

class EditNote extends NoteEvent {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  final String section;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EditNote(
    this.id,
    this.title,
    this.description,
    this.date,
    this.priority,
    this.section,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props =>
      [id, title, description, date, priority, section, createdAt, updatedAt];
}

class SearchNote extends NoteEvent {
  final String title;
  const SearchNote(this.title);

  @override
  List<Object> get props => [title];
}

class DeleteNote extends NoteEvent {
  final String id;
  const DeleteNote(this.id);
  
  @override
  List<Object> get props => [id];
}

class UpdateNote extends NoteEvent {
  final String id;
  const UpdateNote(this.id);

  @override
  List<Object> get props => [id];
}
