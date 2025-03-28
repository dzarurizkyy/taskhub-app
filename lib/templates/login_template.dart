import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/validation.dart';
import '../widgets/header/login_page_header.dart';
import '../widgets/input/input_text.dart';
import '../widgets/input/input_password.dart';
import '../widgets/button/submit_button.dart';
import '../providers/user_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  late bool isButtonEnabled = false;
  late bool isLoginSuccess = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_onInputChanged);
    passController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passController.text.isNotEmpty;
    });
  }

  bool _attemptLogin() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final sanitizeText = HtmlUnescape();

    bool isSuccess = userProvider.loginUser(
      sanitizeText.convert(emailController.text),
      sanitizeText.convert(passController.text),
    );

    setState(() {
      isLoginSuccess = isSuccess;
    });

    if (isSuccess) {
      _saveUserToPrefs(
        userProvider.currentUser!.name,
        userProvider.currentUser!.gender,
      );
    }

    return isSuccess;
  }

  void _saveUserToPrefs(String? name, String? gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name ?? '');
    await prefs.setString("gender", gender ?? '');
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginPageHeader(),
                SizedBox(height: 50),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      InputText(
                        autoFocus: true,
                        title: "Your email address",
                        hintText: "username@gmail.com",
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        controller: emailController,
                        validate: validateEmail,
                      ),
                      SizedBox(height: 15),
                      InputPassword(
                        title: "Choose a password",
                        hintText: "min. 8 characters",
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        controller: passController,
                        validate: validatePassword,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: SubmitButton(
                          isButtonEnabled: isButtonEnabled,
                          title: "Continue",
                          titleBold: FontWeight.w700,
                          validation: _attemptLogin,
                          successMessage: "Login Success",
                          failedMessage: "Invalid email or password",
                          successPadding: 65,
                          failedPadding: 30,
                          formkey: formkey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
