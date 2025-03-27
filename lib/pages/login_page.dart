import 'package:flutter/material.dart';
import '../templates/login_template.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
