import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/widgets/header/home_page_header.dart';
import 'package:taskhub_app/widgets/bottom/navigation_bar_bottom.dart';
import 'package:taskhub_app/widgets/tabbar/note_tabbar.dart';

class Home extends StatefulWidget {
  final String name;
  final String gender;
  final DateTime time;

  const Home({
    super.key,
    required this.name,
    required this.gender,
    required this.time,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSearch = false;
  int _selectedTabIndex = 0;
  List<Note> _getNote = [];
  final List<String> _priority = ["All", "High", "Medium", "Low"];
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String value) {
    if (value.isNotEmpty) {
      _getNote = context.read<NoteProvider>().findByTitle(value);
      setState(() {
        _isSearch = true;
      });
    } else {
      _getNote = [];
      setState(() {
        _isSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _priority.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_isSearch ? 192 : 220),
          child: HomePageHeader(
              time: widget.time,
              name: widget.name,
              gender: widget.gender,
              controller: _searchController,
              handler: _handleSearch,
              isSearch: _isSearch,
              priority: _priority,
              onTabChanged: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              }),
        ),
        body: NoteTabbar(
          isSearch: _isSearch,
          notes: _getNote,
          selectedTabIndex: _selectedTabIndex,
        ),
        extendBody: true,
        bottomNavigationBar: BotttomNavigationBar(),
        backgroundColor: Color.fromRGBO(252, 250, 250, 1),
      ),
    );
  }
}
