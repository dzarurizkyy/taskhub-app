import 'package:flutter/material.dart';
import 'package:taskhub_app/helpers/validation.dart';
import 'package:taskhub_app/widgets/button/submit_button.dart';
import 'package:taskhub_app/widgets/header/login_page_header.dart';
import 'package:taskhub_app/widgets/input/auth_email_input.dart';
import 'package:taskhub_app/widgets/input/auth_password_input.dart';
import 'package:taskhub_app/widgets/input/profileform_gender_input.dart';

class Registration extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  final ValueNotifier<String> selectedGender;
  final ValueNotifier<bool> isButtonEnabled;
  final ValueNotifier<bool> isValidationError;
  final Function(BuildContext) submit;

  const Registration(
      {super.key,
      required this.formKey,
      required this.nameController,
      required this.emailController,
      required this.passController,
      required this.confirmPassController,
      required this.selectedGender,
      required this.isButtonEnabled,
      required this.isValidationError,
      required this.submit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Wrap(
              runSpacing: 12,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: LoginPageHeader(),
                ),
                EmailAuthInput(
                  autoFocus: false,
                  title: "Full Name",
                  hintText: "Enter your full name",
                  controller: nameController,
                  validate: validateName,
                  fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                EmailAuthInput(
                  autoFocus: false,
                  title: "Email",
                  hintText: "Enter your email address",
                  controller: emailController,
                  validate: validateEmail,
                  fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                ValueListenableBuilder(
                  valueListenable: selectedGender,
                  builder: (context, selected, _) {
                    return GenderProfileFormInput(
                      title: "Gender",
                      list: ["male", "female"],
                      initialValue: selected,
                      fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                      borderColor: const Color.fromRGBO(224, 224, 224, 1.0),
                      onChanged: (value) {
                        selectedGender.value = value ?? "";
                      },
                    );
                  },
                ),
                PasswordAuthInput(
                  title: "Password",
                  hintText: "Enter your password",
                  controller: passController,
                  validate: validatePassword,
                  fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                PasswordAuthInput(
                  title: "Confirm Password",
                  hintText: "Enter your confirm password",
                  controller: confirmPassController,
                  validate: (value) =>
                      validateConfirmPassword(passController.text, value),
                  fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isButtonEnabled,
                    builder: (context, enabled, _) {
                      return ValueListenableBuilder<bool>(
                        valueListenable: isValidationError,
                        builder: (context, validation, _) {
                          return SubmitButton(
                            formkey: formKey,
                            title: "Create Account",
                            titleBold: FontWeight.w800,
                            isButtonEnabled: enabled,
                            successMessage:
                                "Your account has been created successfully",
                            failedMessage:
                                "Registration failed. Please try again",
                            successPadding: validation ? 0 : 10,
                            failedPadding: validation ? 10 : 0,
                            validation: () async {
                              return submit(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
