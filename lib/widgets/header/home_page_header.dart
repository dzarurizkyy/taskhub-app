import 'package:flutter/material.dart';
import 'package:taskhub_app/helpers/datetime.dart';
import 'package:taskhub_app/helpers/formating.dart';

class HomePageHeader extends StatefulWidget {
  final DateTime time;
  final String name;
  final String gender;
  final bool isSearch;
  final List<String> priority;
  final TextEditingController controller;
  final void Function(String)? handler;
  final void Function(int)? onTabChanged;

  const HomePageHeader({
    super.key,
    required this.time,
    required this.name,
    required this.gender,
    required this.controller,
    required this.handler,
    required this.isSearch,
    required this.priority,
    required this.onTabChanged,
  });

  @override
  State<HomePageHeader> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Wrap(
          runSpacing: 20,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good ${getTimePeriod(widget.time)},",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                    ),
                    Text(
                      capitalizeText(widget.name),
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(32, 180, 224, 0.15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Image.asset(
                      "assets/images/${widget.gender == "female" ? 'female' : 'male'}-icon.png",
                    ),
                  ),
                )
              ],
            ),
            TextFormField(
              autofocus: false,
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(0, 0, 0, 1.0),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(189, 189, 189, 1.0),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(189, 189, 189, 1.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(224, 224, 224, 1.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(224, 224, 224, 1.0),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
              controller: widget.controller,
              onChanged: widget.handler,
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(widget.isSearch ? 0 : 20),
        child: widget.isSearch
            ? Container()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Color.fromRGBO(32, 180, 224, 1.0),
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(189, 189, 189, 1.0),
                  ),
                  onTap: (value) {
                    setState(() {
                      widget.onTabChanged?.call(value);
                    });
                  },
                  tabs: List.generate(
                    widget.priority.length,
                    (index) => Tab(text: widget.priority[index]),
                  ),
                ),
              ),
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: widget.isSearch ? 172 : 220,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }
}
