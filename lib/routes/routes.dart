import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/class/note_screen_bloc.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/pages/add_note_page.dart';
import 'package:taskhub_app/pages/detail_note_page.dart';
import 'package:taskhub_app/pages/edit_note_page.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/pages/login_page.dart';
import 'package:taskhub_app/pages/edit_profile_page.dart';
import 'package:taskhub_app/pages/registration_page.dart';
import 'package:taskhub_app/service/auth_service.dart';
import 'package:taskhub_app/service/note_service.dart';
import 'package:taskhub_app/service/user_service.dart';

class AppRouter {
  final NoteBloc note = NoteBloc(NoteService());
  final UserBloc user = UserBloc(UserService(), AuthService());
  final NoteScreenBloc noteScreen =
      NoteScreenBloc(initialPriority: "High", initialButtonStatus: false);

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RegistrationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: user,
            child: RegistrationPage(),
          ),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: user,
            child: LoginPage(),
          ),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: note),
              BlocProvider.value(value: user),
            ],
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
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: note),
              BlocProvider.value(value: noteScreen)
            ],
            child: AddNotePage(),
          ),
        );
      case EditNotePage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: note),
              BlocProvider.value(value: noteScreen)
            ],
            child: EditNotePage(),
          ),
        );
      case EditProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: user,
            child: EditProfilePage(),
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
    noteScreen.close();
    user.close();
  }
}
