import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:taskhub_app/bloc/class/user_bloc.dart';
import 'package:taskhub_app/bloc/event/user_event.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/pages/login_page.dart';
import 'package:taskhub_app/templates/registration_template.dart';

class RegistrationPage extends StatelessWidget {
  static const routeName = "/registration";
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final confirmPassController = TextEditingController();
    final ValueNotifier<bool> isValidationError = ValueNotifier(false);
    final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);
    final ValueNotifier<String> selectedGender = ValueNotifier("male");

    void validateForm() {
      isButtonEnabled.value = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passController.text.isNotEmpty &&
          confirmPassController.text.isNotEmpty;
    }

    nameController.addListener(validateForm);
    emailController.addListener(validateForm);
    passController.addListener(validateForm);
    confirmPassController.addListener(validateForm);

    Future<bool> submit(BuildContext context) async {
      final sanitizeText = HtmlUnescape();
      try {
        final name = sanitizeText.convert(nameController.text);
        final email = sanitizeText.convert(emailController.text);
        final password = sanitizeText.convert(passController.text);

        if (!context.mounted) return false;

        context
            .read<UserBloc>()
            .add(RegistrationUser(name, selectedGender.value, email, password));

        isValidationError.value = false;
        saveUserToPrefs(name, selectedGender.value);
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        return true;
      } catch (e) {
        isValidationError.value = true;
        return false;
      }
    }

    return Scaffold(
      body: Center(
        child: Registration(
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          passController: passController,
          confirmPassController: confirmPassController,
          selectedGender: selectedGender,
          isButtonEnabled: isButtonEnabled,
          isValidationError: isValidationError,
          submit: submit,
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
