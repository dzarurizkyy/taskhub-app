import 'package:flutter/material.dart';
import 'package:taskhub_app/helpers/animation.dart';
import '../notification/alert.dart';

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final bool isButtonEnabled;
  final String title;
  final FontWeight titleBold;
  final String successMessage;
  final String failedMessage;
  final double successPadding;
  final double failedPadding;
  final bool Function() validation;

  const SubmitButton({
    super.key,
    required this.formkey,
    required this.title,
    required this.titleBold,
    required this.isButtonEnabled,
    required this.successMessage,
    required this.failedMessage,
    required this.successPadding,
    required this.failedPadding,
    required this.validation,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  void _showSnackBar(BuildContext context, bool isSuccess) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(milliseconds: 900),
      elevation: 0,
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSuccess ? widget.successPadding : widget.failedPadding,
        ),
        child: Alert(
          icon: isSuccess ? Icons.done_rounded : Icons.error_rounded,
          colorAlert: isSuccess
              ? const Color.fromARGB(1000, 63, 125, 88)
              : const Color.fromARGB(1000, 190, 49, 68),
          message: isSuccess ? widget.successMessage : widget.failedMessage,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleSubmit() async {
    if (widget.formkey.currentState!.validate()) {
      bool isValid = widget.validation();

      if (isValid) {
        _showSnackBar(context, true);
        await Future.delayed(Duration(milliseconds: 950));
        if (!mounted) return;

        switch (widget.title) {
          case "Continue":
            Navigator.of(context).pushReplacement(loginTransition());
          case "Add Note":
            Navigator.of(context).pop(addNoteTransition());
        }
      } else {
        _showSnackBar(context, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isButtonEnabled ? _handleSubmit : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(1000, 32, 180, 224),
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        widget.title,
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: 14,
          fontWeight: widget.titleBold,
          color: Colors.white,
        ),
      ),
    );
  }
}
