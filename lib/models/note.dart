class Note {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });
}
