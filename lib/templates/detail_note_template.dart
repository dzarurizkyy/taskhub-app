import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/widgets/card/list_card.dart';
import 'package:taskhub_app/widgets/header/detail_header.dart';
import 'package:taskhub_app/widgets/card/description_card.dart';
import 'package:taskhub_app/widgets/popup/action_popup.dart';

class DetailNoteTemplate extends StatelessWidget {
  final List<ActionButton> actionButton;
  final Note data;

  const DetailNoteTemplate({
    super.key,
    required this.actionButton,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: DetailHeader(
          backRoute: HomePage.routeName,
          actionButton: actionButton,
        ),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoaded) {
            final updatedNote = state.notes.firstWhere(
              (note) => note.id == data.id,
              orElse: () => data,
            );

            final List<ListCard> noteDetail = [
              ListCard(
                label: "Section",
                widget: Text(
                  updatedNote.section,
                  style: const TextStyle(
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
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: Color.fromRGBO(164, 167, 172, 1.0),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat("MMM d, yyy").format(updatedNote.date),
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(172, 172, 172, 1.0),
                      ),
                    )
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
                      color: updatedNote.priority == "High"
                          ? const Color.fromRGBO(255, 232, 232, 1.0)
                          : data.priority == "Medium"
                              ? const Color.fromRGBO(255, 249, 230, 1.0)
                              : const Color.fromRGBO(232, 249, 241, 1.0),
                    ),
                    height: 27,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      child: Text(
                        updatedNote.priority,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          color: updatedNote.priority == "High"
                              ? const Color.fromRGBO(231, 76, 60, 1.0)
                              : data.priority == "Medium"
                                  ? const Color.fromRGBO(243, 156, 18, 1.0)
                                  : const Color.fromRGBO(100, 185, 158, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    updatedNote.title,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 40),
                    child: Wrap(
                      runSpacing: 12,
                      children: List.generate(
                        noteDetail.length + 1,
                        (index) {
                          if (index == noteDetail.length) {
                            return Column(
                              children: [
                                const SizedBox(height: 22),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      172,
                                      172,
                                      172,
                                      0.25,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  height: 1,
                                )
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  noteDetail[index].label,
                                  style: const TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(157, 160, 161, 1.0),
                                  ),
                                ),
                              ),
                              Expanded(child: noteDetail[index].widget)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  DescriptionCard(
                    title: "Description",
                    description: updatedNote.description,
                  )
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
