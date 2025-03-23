import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final List<String> priorities = ["High", "Medium", "Low"];
  int _selectedIndex = 0;

  void _startSelectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );

    if (picked != null) {
      _startDateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void _endSelectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );

    if (picked != null) {
      _endDateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: Text("Add new task",
            style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 22,
                fontWeight: FontWeight.w700)),
        backgroundColor: Color.fromRGBO(248, 244, 244, 1.000));
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 0.65 * bodyHeight,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1.000),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(
                          17,
                          17,
                          26,
                          0.05,
                        ),
                        offset: Offset(0, 1), // (x: 0px, y: 1px)
                        blurRadius: 0, // Tidak ada blur
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(
                          17,
                          17,
                          26,
                          0.1,
                        ),
                        offset: Offset(0, 0), // Tidak ada offset
                        blurRadius: 8, // Blur 8px
                      ),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Name",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(113, 114, 118, 1.000),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(1000, 0, 0, 0),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: "Enter task title",
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Description",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(113, 114, 118, 1.000),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        minLines: 4,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(1000, 0, 0, 0),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: "Describe your task",
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(113, 114, 118, 1.000),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  readOnly: true,
                                  controller: _startDateController,
                                  onTap: () => _startSelectDate(context),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(1000, 0, 0, 0),
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(15),
                                    hintText: "DD/MM/YY",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Due Date",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(113, 114, 118, 1.000),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  readOnly: true,
                                  onTap: () => _endSelectDate(context),
                                  controller: _endDateController,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(1000, 0, 0, 0),
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(15),
                                    hintText: "DD/MM/YY",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Priority",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(113, 114, 118, 1.000),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children:
                            List.generate(priorities.length * 2 - 1, (index) {
                          if (index.isOdd) {
                            return SizedBox(
                              width: 10,
                            );
                          }

                          int btnIndex = index ~/ 2;
                          return Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = btnIndex;
                                });
                              },
                              child: Text(
                                priorities[btnIndex],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(248, 244, 244, 1.000),
      ),
    );
  }
}
