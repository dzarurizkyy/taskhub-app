import 'package:flutter/material.dart';

class DescriptionNoteFormInput extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;

  const DescriptionNoteFormInput({
    super.key,
    required this.title,
    required this.hint,
    required this.controller
  });

  @override
  State<DescriptionNoteFormInput> createState() => _DescriptionNoteFormInputState();
}

class _DescriptionNoteFormInputState extends State<DescriptionNoteFormInput> {
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
          minLines: 4,
          maxLines: 4,
          keyboardType: TextInputType.multiline,
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
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color.fromRGBO(224, 224, 224, 1.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color.fromRGBO(224, 224, 224, 1.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
