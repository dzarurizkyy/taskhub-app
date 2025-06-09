import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String gender;

  const ProfileAvatar({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 115,
        height: 115,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromRGBO(32, 180, 224, 0.10),
        ),
        child: Center(
          child: Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(32, 180, 224, 0.20),
            ),
            child: Padding(
              padding: EdgeInsets.all(gender == "male" ? 10 : 7),
              child: Image.asset("assets/images/$gender-icon.png"),
            ),
          ),
        ),
      ),
    );
  }
}
