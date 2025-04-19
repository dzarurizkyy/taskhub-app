abstract class NoteEvent {}

class FetchNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String title;
  final String description;
  final DateTime date;
  final String priority;

  AddNote(this.title, this.description, this.date, this.priority);
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

  EditNote(
    this.id,
    this.title,
    this.description,
    this.date,
    this.priority,
    this.section,
    this.createdAt,
    this.updatedAt,
  );
}

class SearchNote extends NoteEvent {
  final String title;

  SearchNote(this.title);
}

class DeleteNote extends NoteEvent {
  final String id;

  DeleteNote(this.id);
}

class UpdateNote extends NoteEvent {
  final String id;

  UpdateNote(this.id);
}
