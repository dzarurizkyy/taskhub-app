import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/bloc/state/user_state.dart';
import 'package:taskhub_app/helpers/validation.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/pages/registration_page.dart';
import 'package:taskhub_app/widgets/button/submit_button.dart';
import 'package:taskhub_app/widgets/header/login_page_header.dart';
import 'package:taskhub_app/widgets/input/auth_password_input.dart';
import 'package:taskhub_app/widgets/input/auth_email_input.dart';

class Login extends StatelessWidget {
  final Future<bool> Function(BuildContext, String, String) attemptLogin;
  const Login({super.key, required this.attemptLogin});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passController = TextEditingController();

    emailController.addListener(() {
      context
          .read<UserBloc>()
          .add(UpdateFormStatus(emailController.text, passController.text));
    });
    passController.addListener(() {
      context
          .read<UserBloc>()
          .add(UpdateFormStatus(emailController.text, passController.text));
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const LoginPageHeader(),
              const SizedBox(height: 50),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    EmailAuthInput(
                      autoFocus: true,
                      title: "Your email address",
                      hintText: "username@gmail.com",
                      fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                      controller: emailController,
                      validate: validateEmail,
                    ),
                    const SizedBox(height: 15),
                    PasswordAuthInput(
                      title: "Choose a password",
                      hintText: "min. 6 characters",
                      fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                      controller: passController,
                      validate: validatePassword,
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        bool isButtonEnabled = false;

                        if (state is FormStatusUpdated) {
                          isButtonEnabled = state.isFormValid;
                        }

                        return SizedBox(
                          width: double.infinity,
                          child: SubmitButton(
                            formkey: formKey,
                            title: "Continue",
                            titleBold: FontWeight.w700,
                            isButtonEnabled: isButtonEnabled,
                            successMessage: "Login Success",
                            failedMessage: "Invalid email or password",
                            successPadding: 65,
                            failedPadding: 30,
                            validation: () async {
                              if (formKey.currentState!.validate()) {
                                final success = await attemptLogin(
                                  context,
                                  emailController.text,
                                  passController.text,
                                );
                                if (success) {
                                  if (context.mounted) {
                                    Navigator.of(context)
                                        .pushNamed(HomePage.routeName);
                                  }
                                  return true;
                                } else {
                                  if (context.mounted) {
                                    context.read<UserBloc>().add(
                                          UpdateFormStatus(
                                            emailController.text,
                                            passController.text,
                                          ),
                                        );
                                  }
                                }
                              }
                              return false;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(203, 203, 203, 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RegistrationPage.routeName);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 164, 220, 0.6),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
