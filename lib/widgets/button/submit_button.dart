import 'package:flutter/material.dart';
import '../notification/alert.dart';

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final bool isButtonEnabled;
  final String successMessage;
  final String failedMessage;
  final double successPadding;
  final double failedPadding;
  final bool Function() validation;

  const SubmitButton({
    super.key,
    required this.formkey,
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
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => ElevatedButton(
        onPressed: widget.isButtonEnabled
            ? () {
                if (widget.formkey.currentState!.validate()) {
                  bool isValid = widget.validation();
                  if (isValid == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.successPadding),
                          child: Alert(
                            icon: Icons.done_rounded,
                            colorAlert: Color.fromARGB(1000, 63, 125, 88),
                            message: widget.successMessage,
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.failedPadding),
                          child: Alert(
                            icon: Icons.error_rounded,
                            colorAlert: Color.fromARGB(1000, 190, 49, 68),
                            message: widget.failedMessage,
                          ),
                        ),
                      ),
                    );
                  }
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(1000, 32, 180, 224),
          padding: EdgeInsets.symmetric(vertical: 14),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          "Continue",
          style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
