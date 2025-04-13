import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/widgets/card/description_card.dart';
import 'package:taskhub_app/widgets/card/list_card.dart';
import 'package:taskhub_app/widgets/header/detail_header.dart';
import 'package:taskhub_app/widgets/popup/action_popup.dart';

class DetailNoteTemplate extends StatefulWidget {
  final List<ActionButton> actionButton;
  final Note data;
  const DetailNoteTemplate({
    super.key,
    required this.actionButton,
    required this.data,
  });

  @override
  State<DetailNoteTemplate> createState() => _DetailNoteTemplateState();
}

class _DetailNoteTemplateState extends State<DetailNoteTemplate> {
  @override
  Widget build(BuildContext context) {
    final List<ListCard> noteDetailList = [
      ListCard(
        label: "Section",
        widget: Text(
          widget.data.section,
          style: TextStyle(
            fontSize: 13,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      ListCard(
        label: "Due Date",
        widget: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 20,
              color: Color.fromRGBO(164, 167, 172, 1.0),
            ),
            SizedBox(width: 6),
            Text(
              DateFormat("MMM d, yyyy").format(widget.data.date),
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(172, 172, 172, 1.0),
              ),
            ),
          ],
        ),
      ),
      ListCard(
        label: "Priority",
        widget: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.data.priority == "High"
                  ? Color.fromRGBO(255, 232, 232, 1.0)
                  : widget.data.priority == "Medium"
                      ? Color.fromRGBO(255, 249, 230, 1.0)
                      : Color.fromRGBO(232, 249, 241, 1.0),
            ),
            height: 27,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 10,
              ),
              child: Text(
                widget.data.priority,
                style: TextStyle(
                  color: widget.data.priority == "High"
                      ? Color.fromRGBO(231, 76, 60, 1.0)
                      : widget.data.priority == "Medium"
                          ? Color.fromRGBO(243, 156, 18, 1.0)
                          : Color.fromRGBO(100, 185, 158, 1.0),
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: DetailHeader(
          backRoute: HomePage.routeName,
          actionButton: widget.actionButton,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Consumer<NoteProvider>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.title,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 40),
                    child: Wrap(
                      runSpacing: 12,
                      children: List.generate(
                        noteDetailList.length + 1,
                        (index) {
                          if (index == noteDetailList.length) {
                            return Column(children: [
                              SizedBox(height: 22),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(172, 172, 172, 0.25),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                height: 1,
                              ),
                            ]);
                          }
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  noteDetailList[index].label,
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: Color.fromRGBO(157, 160, 161, 1.0),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(child: noteDetailList[index].widget)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  DescriptionCard(
                    title: "Description",
                    description: widget.data.description,
                  )
                ],
              );
            },
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
