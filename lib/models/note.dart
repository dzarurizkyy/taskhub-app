import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Note(
      id: data["id"] ?? "",
      title: data["title"] ?? "",
      description: data["description"] ?? "",
      date: (data["date"] as Timestamp).toDate(),
      priority: data["priority"] ?? "",
      section: data["section"] ?? "",
      createdAt: (data["created_at"] as Timestamp).toDate(),
      updatedAt: (data["updated_at"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "userId": 1};
  }
}
