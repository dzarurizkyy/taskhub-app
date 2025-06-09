import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? name;
  final String? gender;
  final String? email;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.prefs(String name, String gender) {
    return User(
      id: null,
      name: name,
      gender: gender,
      email: null,
      password: null,
      createdAt: null,
      updatedAt: null,
    );
  }

  factory User.empty() {
    return User(
      id: null,
      name: "",
      gender: "",
      email: "",
      password: "",
      createdAt: null,
      updatedAt: null,
    );
  }

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      id: data["id"] ?? "",
      name: data["name"] ?? "",
      gender: data["gender"] ?? "",
      email: data["email"] ?? "",
      password: data["password"],
      createdAt: (data["created_at"] as Timestamp).toDate(),
      updatedAt: (data["updated_at"] as Timestamp).toDate(),
    );
  }
}
