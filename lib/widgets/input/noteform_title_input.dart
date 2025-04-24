import 'package:flutter/material.dart';

class TitleNoteFormInput extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;

  const TitleNoteFormInput({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
  });

  @override
  State<TitleNoteFormInput> createState() => _TitleNoteFormInputState();
}

class _TitleNoteFormInputState extends State<TitleNoteFormInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 13,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(113, 114, 118, 1.0),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          style: TextStyle(
            fontSize: 13,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(0, 0, 0, 1.0),
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(15),
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 13,
              fontFamily: "Nunito",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(158, 158, 158, 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromRGBO(224, 224, 224, 1.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromRGBO(224, 224, 224, 1.0)),
            ),
          ),
        )
      ],
    );
  }
}
