import 'package:flutter/material.dart';
import 'package:taskhub_app/templates/home_template.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
