import 'package:taskhub_app/models/user.dart';

class UserService {
  final List<User> _users = [
    User(
      id: 1,
      name: "Dzaru Rizky Fathan Fortuna",
      gender: "male",
      email: "dzarurizkybusiness@gmail.com",
      password: "dzaru1234",
      createdAt: DateTime.parse("2025-03-10"),
      updatedAt: DateTime.parse("2025-03-10"),
    ),
    User(
      id: 2,
      name: "Yuuki Asuna",
      gender: "female",
      email: "yuukiasuna@yahoo.com",
      password: "asuna2024",
      createdAt: DateTime.parse("2025-03-10"),
      updatedAt: DateTime.parse("2025-03-10"),
    )
  ];

  Future<User> loginUser(String email, String password) async {
    final user = _users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User.empty(),
    );

    if (user.id == 0) {
      throw Exception('user not found');
    }

    return user;
  }

  Future<User> updateUserProfile(User user) async{
    final int selectedUser = _users.indexWhere((data) => data.id == user.id);

    if (user.id == 0) {
      throw Exception("user not found");
    }

    final currentUser = _users[selectedUser];
    final User updatedUser = User(
      id: user.id,
      name: user.name,
      email: user.email,
      gender: user.gender,
      password: user.password,
      createdAt: currentUser.createdAt,
      updatedAt: DateTime.now(),
    );

    return updatedUser;
  }
}
