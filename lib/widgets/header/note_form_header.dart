import 'package:flutter/material.dart';
import 'package:taskhub_app/pages/home_page.dart';

class NoteFormHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const NoteFormHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 15),
        child: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop(HomePage.routeName);
          },
          color: Color.fromRGBO(0, 0, 0, 1.0),
        ),
      ),
      leadingWidth: 45,
      title: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w800,
            color: Color.fromRGBO(0, 0, 0, 1.0),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          height: 1.4,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
