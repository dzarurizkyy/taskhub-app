import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:taskhub_app/pages/add_note_page.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/widgets/card/note_card.dart';
import 'package:taskhub_app/models/note.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Good Morning,",
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                          ),
                        ),
                        Text(
                          "Dzaru!",
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(32, 180, 224, 0.2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Image.asset("assets/images/profile.png"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                TextFormField(
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(189, 189, 189, 1.0),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
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
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Padding(
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
                onTap: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                tabs: [
                  Tab(
                    text: "All",
                  ),
                  Tab(text: "High"),
                  Tab(text: "Medium"),
                  Tab(text: "Low"),
                ],
              ),
            ),
          ),
          toolbarHeight: 220,
          backgroundColor: Color.fromRGBO(248, 244, 244, 1.0),
        ),
        body: Consumer<NoteProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: PageTransitionSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    fillColor: Colors.transparent,
                    child: child,
                  );
                },
                child: _buildTabContent(provider),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: BottomAppBar(
            color: Color.fromRGBO(248, 244, 244, 1.0),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    splashColor: Colors.black12,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.home_rounded,
                        size: 30,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddNotePage.routeName);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    splashColor: Colors.black12,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(248, 244, 244, 1.0),
      ),
    );
  }

  Widget _buildTabContent(NoteProvider provider) {
    switch (_selectedTabIndex) {
      case 0: // All
        return _buildNoteList(provider.notes, _selectedTabIndex.toString());
      case 1: // High
        return _buildNoteList(
            provider.findByPriority("High"), _selectedTabIndex.toString());
      case 2: // Medium
        return _buildNoteList(
            provider.findByPriority("Medium"), _selectedTabIndex.toString());
      case 3: // Low
        return _buildNoteList(
            provider.findByPriority("Low"), _selectedTabIndex.toString());
      default:
        return Container(); // Fallback
    }
  }

  Widget _buildNoteList(List<Note> notes, String value) {
    return ListView.separated(
      key: ValueKey(_selectedTabIndex),
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(
          title: note.title,
          description: note.description,
          day: DateFormat("EEE").format(note.date).toUpperCase(),
          date: DateFormat("d").format(note.date),
          time: DateFormat("HH:mm a").format(note.date),
          priority: note.priority,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Color.fromRGBO(248, 244, 244, 1.0),
          height: 12,
        );
      },
      itemCount: notes.length,
    );
  }
}
