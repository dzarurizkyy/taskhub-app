import 'package:flutter/material.dart';

class ListCard {
  String label;
  Widget widget;

  ListCard({
    required this.label,
    required this.widget
  });
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
