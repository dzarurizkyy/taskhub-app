import 'package:flutter/material.dart';
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
  final double fontSizeNotification;
  final Future<bool> Function()? validation;

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
    required this.fontSizeNotification,
    required this.validation,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  void _handleSubmit() async {
    if (!widget.formkey.currentState!.validate()) return;
    bool isValid = await widget.validation?.call() ?? false;

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(milliseconds: 1500),
        elevation: 0,
        content: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isValid ? widget.successPadding : widget.failedPadding,
          ),
          child: Alert(
            icon: isValid ? Icons.done_rounded : Icons.error_rounded,
            colorAlert: isValid
                ? const Color.fromARGB(1000, 63, 125, 88)
                : const Color.fromARGB(1000, 190, 49, 68),
            fontSizeNotification: widget.fontSizeNotification,
            message: isValid ? widget.successMessage : widget.failedMessage,
          ),
        ),
      ),
    );
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
