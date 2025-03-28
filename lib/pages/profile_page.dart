import 'package:flutter/material.dart';
import 'package:taskhub_app/widgets/bottom/navigation_bar_bottom.dart';

class ProfilePage extends StatelessWidget {
  static const pageRoute = "/profile";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Colors.grey.shade600,
            ),
            SizedBox(height: 10),
            Text(
              "This page under maintenance",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotttomNavigationBar(),
    );
  }
}
