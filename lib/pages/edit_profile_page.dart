import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/templates/edit_profile_template.dart';
import 'package:taskhub_app/pages/login_page.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = "/edit-profile";
  const EditProfilePage({super.key});

  Future<bool> _updateProfile(
    BuildContext context,
    String? id,
    String name,
    String email,
    String gender,
    String password,
  ) async {
    final userBloc = context.read<UserBloc>();
    final completer = Completer<bool>();
    late final StreamSubscription sub;

    sub = userBloc.stream.listen(
      (state) {
        if (state is UserLoaded) {
          completer.complete(true);
          saveUserToPrefs(name, gender);
          sub.cancel();
        }

        if (state is UserError) {
          completer.complete(false);
          sub.cancel();
        }
      },
    );

    final User updatedUser = User(
      id: id,
      name: name,
      gender: gender,
      email: email,
      password: password,
      createdAt: null,
      updatedAt: null,
    );

    userBloc.add(UpdateProfile(updatedUser));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return EditProfileTemplate(updateProfile: _updateProfile);
  }
}
