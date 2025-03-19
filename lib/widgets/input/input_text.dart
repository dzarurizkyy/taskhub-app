import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final bool autoFocus;
  final String title;
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final String? Function(String?) validate;

  const InputText({
    super.key,
    required this.autoFocus,
    required this.title,
    required this.hintText,
    required this.fillColor,
    required this.controller,
    required this.validate,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
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
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
