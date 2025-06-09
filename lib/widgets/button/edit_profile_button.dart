import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const EditProfileButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 13),
          backgroundColor: const Color.fromARGB(1000, 32, 180, 224),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
