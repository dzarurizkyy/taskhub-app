import 'package:flutter/material.dart';

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
        padding: EdgeInsets.only(left: 20, bottom: 10),
        child: Icon(
          Icons.arrow_back_rounded,
          color: Color.fromRGBO(113, 114, 118, 1.0),
        ),
      ),
      leadingWidth: 50,
      title: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: "Nunito",
            fontWeight: FontWeight.w800,
            color: Color.fromRGBO(113, 114, 118, 1.0),
          ),
        ),
      ),
      toolbarHeight: 45,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color.fromRGBO(113, 114, 118, 0.2),
          height: 2,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
