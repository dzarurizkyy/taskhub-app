import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final List<User> _allUser = [
    User(
      id: 1,
      email: "dzarurizkybusiness@gmail.com",
      password: "dzaru1234",
      createdAt: "2025-03-10 20:29:11",
      updatedAt: "2025-03-10 20:29:11",
    ),
    User(
      id: 2,
      email: "kirigayakazuto@sao.com",
      password: "kirito1234",
      createdAt: "2025-03-10 22:00:00",
      updatedAt: "2025-03-10 22:00:00",
    )
  ];

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool loginUser(String email, String password) {
    final user = _allUser.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(
        id: 0,
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
