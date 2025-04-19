class User {
  final int id;
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
      id: 0,
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
      id: 0,
      name: "",
      gender: "",
      email: "",
      password: "",
      createdAt: null,
      updatedAt: null,
    );
  }
}
