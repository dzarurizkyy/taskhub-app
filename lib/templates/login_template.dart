import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import '../helpers/validation.dart';
import '../widgets/header/logo.dart';
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

    return isSuccess;
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(),
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
      ),
    );
  }
}
