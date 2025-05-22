import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/templates/login_template.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveUserToPrefs(String? name, String? gender) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("name", name ?? "");
  await prefs.setString("gender", gender ?? "");
}

class LoginPage extends StatelessWidget {
  static const routeName = "/login";
  const LoginPage({super.key});

  Future<bool> _attemptLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    final userBloc = context.read<UserBloc>();
    final completer = Completer<bool>();
    late final StreamSubscription sub;

    sub = userBloc.stream.listen(
      (state) {
        if (state is UserLoaded) {
          completer.complete(true);
          saveUserToPrefs(state.user.name, state.user.gender);
          sub.cancel();
        } else if (state is UserError) {
          print("error ${state.message}");
          completer.complete(false);
          sub.cancel();
        }
      },
    );

    userBloc.add(LoginUser(email, password));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Login(attemptLogin: _attemptLogin);
  }
}
