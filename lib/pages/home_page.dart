import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskhub_app/providers/note_provider.dart';
import '../templates/home_template.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name = "";
  late String gender = "";

  void _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? namePrefs = prefs.getString("name");
    String? genderPrefs = prefs.getString("gender");

    if (namePrefs != null && genderPrefs != null) {
      setState(() {
        name = namePrefs;
        gender = genderPrefs;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserFromPrefs();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<NoteProvider>(context, listen: false).fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Home(
      name: name,
      gender: gender,
      time: DateTime.now(),
    );
  }
}
