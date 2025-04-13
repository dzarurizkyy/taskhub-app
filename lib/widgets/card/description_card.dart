import 'package:flutter/material.dart';

class DescriptionCard extends StatelessWidget {
  final String title;
  final String description;

  const DescriptionCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(168, 170, 172, 1.0),
          ),
        ),
      ],
    );
  }
}
