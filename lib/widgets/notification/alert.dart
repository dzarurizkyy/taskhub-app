import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final IconData icon;
  final Color colorAlert;
  final String message;
  final double fontSizeNotification;

  const Alert({
    super.key,
    required this.icon,
    required this.colorAlert,
    required this.message,
    required this.fontSizeNotification
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: colorAlert,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Icon(icon, color: colorAlert, size: 20),
          ),
          SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: fontSizeNotification,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
