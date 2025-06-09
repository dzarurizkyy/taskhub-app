import 'package:flutter/material.dart';
import 'package:taskhub_app/pages/add_note_page.dart';
import 'package:taskhub_app/pages/home_page.dart';
import 'package:taskhub_app/pages/edit_profile_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 90,
      color: Color.fromRGBO(252, 250, 250, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.black12,
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.home_rounded,
                    size: 35,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddNotePage.routeName);
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.black12,
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(EditProfilePage.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
