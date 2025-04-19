import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final List<User> _allUser = [
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

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool loginUser(String email, String password) {
    final user = _allUser.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(
        id: 0,
        name: null,
        gender: null,
        email: null,
        password: null,
        createdAt: null,
        updatedAt: null,
      ),
    );

    if (user.id != 0) {
      _currentUser = user;
      notifyListeners();
      return true;
    }

    return false;
  }
}
