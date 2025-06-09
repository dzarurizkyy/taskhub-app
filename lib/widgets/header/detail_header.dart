import 'package:flutter/material.dart';
import 'package:taskhub_app/widgets/popup/action_popup.dart';

class DetailHeader extends StatelessWidget {
  final String backRoute;
  final List<ActionButton> actionButton;

  const DetailHeader({
    super.key,
    required this.backRoute,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color.fromRGBO(172, 172, 172, 1.0),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(backRoute);
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: ActionPopup(actionButton: actionButton),
        ),
      ],
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
