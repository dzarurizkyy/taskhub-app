import 'package:flutter/material.dart';

class PasswordAuthInput extends StatefulWidget {
  final String title;
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final String? Function(String?) validate;

  const PasswordAuthInput({
    super.key,
    required this.title,
    required this.hintText,
    required this.fillColor,
    required this.controller,
    required this.validate,
  });

  @override
  State<PasswordAuthInput> createState() => _PasswordAuthInputState();
}

class _PasswordAuthInputState extends State<PasswordAuthInput> {
  late bool isObscure = false;

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
          autocorrect: false,
          enableSuggestions: false,
          validator: widget.validate,
          controller: widget.controller,
          obscureText: isObscure,
          style: TextStyle(
            color: Color.fromARGB(1000, 0, 0, 0),
            fontFamily: "Nunito",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: widget.fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: isObscure
                        ? Colors.grey.shade300
                        : Color.fromARGB(255, 0, 2, 0),
                  ),
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
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
        )
      ],
    );
  }
}
