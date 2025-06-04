import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/templates/home_template.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";
  const HomePage({super.key});

  Future<User> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 1));
    return User.prefs(
      prefs.getString("name") ?? "",
      prefs.getString("gender") ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (!context.mounted) return {};
      context.read<UserBloc>().add(LoadCurrentUser());
    });

    return FutureBuilder<User>(
      future: _loadUserPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(1000, 32, 180, 224),
              ),
            ),
            backgroundColor: const Color.fromRGBO(252, 250, 250, 1),
          );
        }
        return Home(
          name: snapshot.data!.name ?? "",
          gender: snapshot.data!.gender ?? "",
        );
      },
    );
  }
}
