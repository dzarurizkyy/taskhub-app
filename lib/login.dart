import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late bool obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be null or empty";
    }

    if (!value.contains("@") || !value.contains(".com")) {
      return "Invalid email address";
    }

    return null;
  }

  String? _validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be null or empty";
    }

    if (value.length < 8 && value.isNotEmpty) {
      return "Password must be at least 8 characters";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icon.png",
                          width: 26,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          "TaskHub",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Power-up your productivity",
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color.fromARGB(255, 0, 2, 0)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your email address",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: "username@gmail.com",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(100, 4, 164, 228),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose a password",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextField(
                                obscureText: obscureText,
                                controller: _passController,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: "min. 8 characters",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(100, 4, 164, 228),
                                      width: 1.5,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.only(right: 10),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                        obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: obscureText
                                            ? Colors.grey.shade400
                                            : Color.fromARGB(255, 0, 2, 0)),
                                    iconSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Builder(
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          String? emailMessage =
                              _validateEmail(_emailController.text);
                          String? passMessage =
                              _validatePass(_passController.text);

                          if (emailMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(1000, 190, 49, 68),
                                margin: EdgeInsets.symmetric(
                                  horizontal: emailMessage ==
                                          "Email cannot be null or empty"
                                      ? 55
                                      : 80,
                                  vertical: 25,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.error_rounded,
                                        color:
                                            Color.fromARGB(1000, 190, 49, 68),
                                        size: 20,
                                        weight: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      emailMessage,
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (passMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(1000, 190, 49, 68),
                                margin: EdgeInsets.symmetric(
                                  horizontal: passMessage ==
                                          "Password cannot be null or empty"
                                      ? 40
                                      : 30,
                                  vertical: 25,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.error_rounded,
                                        color:
                                            Color.fromARGB(1000, 190, 49, 68),
                                        size: 20,
                                        weight: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      passMessage,
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (_emailController.text !=
                                  "dzarurizkybusiness@gmail.com" ||
                              _passController.text != "dzaru1234") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(1000, 190, 49, 68),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 25,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.error_rounded,
                                        color:
                                            Color.fromARGB(1000, 190, 49, 68),
                                        size: 20,
                                        weight: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Incorect email or password",
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(1000, 63, 125, 88),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 105,
                                  vertical: 25,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.done_rounded,
                                        color:
                                            Color.fromARGB(1000, 63, 125, 88),
                                        size: 20,
                                        weight: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Login Success",
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(1000, 32, 180, 224),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
