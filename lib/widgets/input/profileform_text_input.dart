import 'package:flutter/material.dart';

class TextProfileFormInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const TextProfileFormInput({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(0, 0, 0, 0.8),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(158, 158, 158, 0.20),
            contentPadding: EdgeInsets.only(left: 20, bottom: 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
