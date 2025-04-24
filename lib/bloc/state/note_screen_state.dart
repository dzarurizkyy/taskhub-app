abstract class NoteScreenState {}

class NoteScreenLoaded extends NoteScreenState {
  final String priority;
  final bool buttonStatus;

  NoteScreenLoaded({required this.priority, required this.buttonStatus});

  NoteScreenLoaded copyWith({String? priority, bool? buttonStatus}) {
    return NoteScreenLoaded(
      priority: priority ?? this.priority,
      buttonStatus: buttonStatus ?? this.buttonStatus,
    );
  }
}
