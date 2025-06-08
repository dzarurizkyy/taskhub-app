import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/app.dart';
import 'package:taskhub_app/helpers/formating.dart';
import 'package:taskhub_app/helpers/validation.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/service/auth_service.dart';
import 'package:taskhub_app/widgets/card/profile_avatar.dart';
import 'package:taskhub_app/widgets/button/edit_profile_button.dart';
import 'package:taskhub_app/widgets/bottom/navigation_bar_bottom.dart';
import 'package:taskhub_app/widgets/input/profileform_text_input.dart';
import 'package:taskhub_app/widgets/input/profileform_gender_input.dart';
import 'package:taskhub_app/widgets/input/profileform_password_input.dart';
import 'package:taskhub_app/widgets/notification/alert.dart';

class EditProfileTemplate extends StatelessWidget {
  static const routeName = "/profile";
  final authService = AuthService();
  final Future<bool> Function(
      BuildContext, String?, String, String, String, String) updateProfile;
  EditProfileTemplate({super.key, required this.updateProfile});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final ValueNotifier<String> gender = ValueNotifier("male");
    final ValueNotifier<bool> visiblePassword = ValueNotifier(true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontFamily: "Nunito",
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 250, 250, 1.0),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 32, 180, 224),
                ),
              ),
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            );
          } else if (state is UserLoaded) {
            final User user = state.user;
            Future.microtask(
              () {
                nameController.text =
                    capitalizeText(user.name ?? "", "fullname");
                emailController.text = user.email ?? "";
                passwordController.text = user.password ?? "";
                gender.value = user.gender ?? "male";
              },
            );
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileAvatar(gender: user.gender ?? "male"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 30),
                    child: Form(
                      key: formKey,
                      child: Wrap(
                        runSpacing: 15,
                        children: [
                          TextProfileFormInput(
                            title: "Name",
                            controller: nameController,
                          ),
                          TextProfileFormInput(
                            title: "Email",
                            controller: emailController,
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable: gender,
                            builder: (context, value, _) {
                              return GenderProfileFormInput(
                                title: "Gender",
                                list: ["male", "female"],
                                initialValue: gender.value,
                                fillColor:
                                    const Color.fromRGBO(158, 158, 158, 0.20),
                                borderColor:
                                    const Color.fromRGBO(158, 158, 158, 0.20),
                                onChanged: (value) {
                                  gender.value = value ?? "male";
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: visiblePassword,
                            builder: (context, value, _) {
                              return PasswordProfileFormInput(
                                title: "Password",
                                isVisible: visiblePassword.value,
                                controller: passwordController,
                                onTap: () {
                                  visiblePassword.value =
                                      !visiblePassword.value;
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14, bottom: 18),
                            child: EditProfileButton(
                              title: "Save Changes",
                              onPressed: () async {
                                final failedSnackbar = _buildEditStatus(
                                  "failed",
                                  nameController,
                                  emailController,
                                  passwordController,
                                );

                                if (failedSnackbar != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(failedSnackbar);
                                } else {
                                  final bool isSuccess = await updateProfile(
                                    context,
                                    user.id,
                                    nameController.text,
                                    emailController.text,
                                    gender.value,
                                    passwordController.text,
                                  );
                                  if (isSuccess) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      _buildEditStatus(
                                        "success",
                                        nameController,
                                        emailController,
                                        passwordController,
                                      )!,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                authService.logout();
                                if (!context.mounted) return;
                                Navigator.pushReplacementNamed(
                                    context, App.routeName);
                              },
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color:
                                      const Color.fromARGB(1000, 32, 180, 224),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is UserError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BottomNavbar(),
      backgroundColor: Color.fromRGBO(252, 250, 250, 1.0),
    );
  }
}

SnackBar? _buildEditStatus(
  String option,
  TextEditingController name,
  TextEditingController email,
  TextEditingController password,
) {
  if (option == "failed") {
    late String message;
    late double padding;
    final String? isEmailValid = validateEmail(email.text);
    final String? isPasswordValid = validatePassword(password.text);

    if (name.text == "" || email.text == "" || password.text == "") {
      message =
          "Please enter your ${name.text.isEmpty ? 'name' : email.text.isEmpty ? 'email' : 'password'}";
      padding = 30;
    } else if (isEmailValid != null || isPasswordValid != null) {
      message = "${isEmailValid ?? isPasswordValid}";
      padding = isPasswordValid != null ? 5 : 40;
    } else if (isEmailValid == null && isPasswordValid == null) {
      return null;
    }

    return SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 800),
      elevation: 0,
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: Alert(
          icon: Icons.error_rounded,
          colorAlert: Color.fromRGBO(190, 49, 68, 1.0),
          message: message,
          fontSizeNotification: 12,
        ),
      ),
    );
  }

  return SnackBar(
    backgroundColor: Colors.transparent,
    duration: const Duration(milliseconds: 800),
    elevation: 0,
    content: Alert(
      icon: Icons.done_rounded,
      colorAlert: Color.fromRGBO(63, 125, 88, 1.0),
      message: "Your profile has been successfully updated",
      fontSizeNotification: 12,
    ),
  );
}
