import 'package:flutter/material.dart';

class DateNoteformInput extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final VoidCallback picker;

  const DateNoteformInput({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.picker,
  });

  @override
  State<DateNoteformInput> createState() => _DateNoteformInputState();
}

class _DateNoteformInputState extends State<DateNoteformInput> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
            readOnly: true,
            controller: widget.controller,
            onTap: widget.picker,
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
                borderSide:
                    BorderSide(color: Color.fromRGBO(224, 224, 224, 1.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    BorderSide(color: Color.fromRGBO(224, 224, 224, 1.0)),
              ),
              suffixIcon: Icon(Icons.keyboard_arrow_down, size: 15),
            ),
          )
        ],
      ),
    );
  }
}
