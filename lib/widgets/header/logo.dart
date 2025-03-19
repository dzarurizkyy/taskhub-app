import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/icon.png", width: 26),
              SizedBox(width: 14),
              Text(
                "TaskHub",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              )
            ],
          ),
          SizedBox(height: 14),
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
    );
  }
}
