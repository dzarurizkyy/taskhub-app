class Note {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  final String section;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.section,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    final String? id,
    final String? title,
    final String? description,
    final DateTime? date,
    final String? priority,
    final String? section,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      section: section ?? this.section,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"].toString(),
      title: json["title"] ?? "",
      description: json["body"] ?? "",
      date: DateTime.now(),
      priority: "Low",
      section: "In Progress",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "userId": 1};
  }
}
