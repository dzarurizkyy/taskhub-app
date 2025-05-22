import 'package:flutter/material.dart';

class EmailAuthInput extends StatefulWidget {
  final bool autoFocus;
  final String title;
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final String? Function(String?) validate;

  const EmailAuthInput({
    super.key,
    required this.autoFocus,
    required this.title,
    required this.hintText,
    required this.fillColor,
    required this.controller,
    required this.validate,
  });

  @override
  State<EmailAuthInput> createState() => _EmailAuthInputState();
}

class _EmailAuthInputState extends State<EmailAuthInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: "Nunito",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          autofocus: widget.autoFocus,
          autocorrect: false,
          enableSuggestions: false,
          controller: widget.controller,
          validator: widget.validate,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Color.fromARGB(1000, 0, 0, 0),
            fontFamily: "Nunito",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color.fromARGB(100, 4, 164, 228),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color.fromARGB(1000, 190, 49, 68),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color.fromARGB(100, 4, 164, 228),
                width: 1.5,
              ),
            ),
            errorStyle: TextStyle(height: 2),
          ),
        ),
      ],
    );
  }
}
