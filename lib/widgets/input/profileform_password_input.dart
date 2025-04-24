import 'package:flutter/material.dart';

class PasswordProfileFormInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isVisible;
  final Function() onTap;

  const PasswordProfileFormInput({
    super.key,
    required this.title,
    required this.isVisible,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
          obscureText: isVisible,
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
            suffixIcon: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  onTap();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromRGBO(0, 2, 0, 1.0),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
