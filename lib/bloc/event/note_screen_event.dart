abstract class NoteScreenEvent {}

class ChangePriority extends NoteScreenEvent {
  final String priority;
  ChangePriority(this.priority);
}

class ChangeButtonStatus extends NoteScreenEvent {
  final String title;
  final String description;
  final String date;
  final String time;

  ChangeButtonStatus(this.title, this.description, this.date, this.time);
}
