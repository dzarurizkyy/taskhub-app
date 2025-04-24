import 'package:flutter/material.dart';
import 'package:taskhub_app/helpers/formating.dart';

class GenderProfileFormInput extends StatelessWidget {
  final String title;
  final List<String> list;
  final String initialValue;
  final Function(String?) onChanged;

  const GenderProfileFormInput({
    super.key,
    required this.title,
    required this.list,
    required this.initialValue,
    required this.onChanged,
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
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromRGBO(158, 158, 158, 0.20),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                onChanged: onChanged,
                value: initialValue,
                items: list.map(
                  (data) {
                    return DropdownMenuItem<String>(
                      value: data,
                      child: Text(
                        capitalizeText(data, "fullname"),
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.8),
                        ),
                      ),
                    );
                  },
                ).toList(),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(0, 2, 0, 1.0),
                  ),
                ),
                dropdownColor: Color.fromRGBO(252, 250, 250, 0.95),
                borderRadius: BorderRadius.circular(15),
                elevation: 1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
