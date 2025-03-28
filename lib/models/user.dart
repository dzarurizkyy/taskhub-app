class User {
  final int id;
  final String? name;
  final String? gender;
  final String? email;
  final String? password;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });
}
