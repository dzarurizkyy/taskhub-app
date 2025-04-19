import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/pages/add_note_page.dart';
import 'package:taskhub_app/pages/detail_note_page.dart';
import 'package:taskhub_app/pages/edit_note_page.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/pages/login_page.dart';
import 'package:taskhub_app/pages/profile_page.dart';

class AppRouter {
  final NoteBloc note = NoteBloc();
  final UserBloc user = UserBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: user,
            child: LoginPage(),
          ),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: note,
            child: HomePage(),
          ),
        );
      case DetailNotePage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: note,
            child: DetailNotePage(),
          ),
        );
      case AddNotePage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: note,
            child: AddNotePage(),
          ),
        );
      case EditNotePage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: note,
            child: EditNotePage(),
          ),
        );
      case ProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: user,
            child: ProfilePage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("Page Not Found"),
            ),
          ),
        );
    }
  }

  void dispose() {
    note.close();
    user.close();
  }
}
