import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/pages/detail_note_page.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailNotePage.routeName, arguments: note);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1.0),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(17, 17, 26, 0.05),
                offset: Offset(0, 1),
                blurRadius: 0,
              ),
              BoxShadow(
                color: Color.fromRGBO(17, 17, 26, 0.1),
                offset: Offset(0, 0),
                blurRadius: 8,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(113, 114, 118, 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("EEE").format(note.date).toUpperCase(),
                        style: TextStyle(
                          fontSize: 7,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(113, 114, 118, 1.0),
                        ),
                      ),
                      Text(
                        DateFormat("d").format(note.date),
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(113, 114, 118, 1.0),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(113, 114, 118, 1.0),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        DateFormat("HH:MM").format(note.date),
                        style: TextStyle(
                          fontSize: 11.5,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(182, 188, 186, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: note.priority == "High"
                        ? Color.fromRGBO(216, 64, 64, 1.0)
                        : note.priority == "Medium"
                            ? Color.fromRGBO(246, 220, 67, 1.0)
                            : Color.fromARGB(1000, 63, 125, 88),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              note.description,
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(180, 180, 180, 1.0),
              ),
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
