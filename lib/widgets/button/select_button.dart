import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  final String type;
  final String title;
  final List<String> choice;
  final String priority;
  final ValueChanged<String> selected;

  const SelectButton({
    super.key,
    required this.type,
    required this.title,
    required this.choice,
    required this.priority,
    required this.selected,
  });

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    int getIndex(String option, String type) {
      if (type == "note_form") {
        return option == "Low"
            ? 2
            : option == "Medium"
                ? 1
                : 0;
      }

      return option == "Male" ? 0 : 1;
    }

    int selectedIndex = getIndex(widget.priority, widget.type);
    return Column(
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
        Row(
          children: List.generate(widget.choice.length * 2 - 1, (index) {
            if (index.isOdd) {
              return SizedBox(width: 10);
            }

            int btnIndex = index ~/ 2;
            return Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  overlayColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  backgroundColor: selectedIndex == btnIndex
                      ? Color.fromRGBO(180, 225, 240, 0.4)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: selectedIndex == btnIndex
                          ? Color.fromRGBO(180, 225, 240, 0.4)
                          : Color.fromRGBO(224, 224, 224, 1.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = btnIndex;
                    widget.selected(widget.choice[btnIndex]);
                  });
                },
                child: Text(
                  widget.choice[btnIndex],
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: "Nunito",
                    fontWeight: selectedIndex == btnIndex
                        ? FontWeight.w700
                        : FontWeight.w600,
                    color: selectedIndex == btnIndex
                        ? Color.fromRGBO(53, 182, 215, 0.95)
                        : Color.fromRGBO(158, 158, 158, 1.0),
                  ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
