import 'package:flutter/material.dart';

class ActionButton {
  final String title;
  final IconData icon;
  final VoidCallback function;

  ActionButton({
    required this.title,
    required this.icon,
    required this.function,
  });
}

class ActionPopup extends StatelessWidget {
  final List<ActionButton> actionButton;
  const ActionPopup({super.key, required this.actionButton});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    actionButton.length,
                    (index) {
                      return ListTile(
                        leading: Icon(
                          actionButton[index].icon,
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                        ),
                        title: Text(
                          actionButton[index].title,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          actionButton[index].function();
                        },
                      );
                    },
                  ),
                ),
              );
            });
      },
      icon: Icon(
        Icons.more_vert_rounded,
        color: Color.fromRGBO(172, 172, 172, 1.0),
      ),
    );
  }
}
