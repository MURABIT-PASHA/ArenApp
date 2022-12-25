import 'package:flutter/material.dart';
import 'error_lottie.dart';

class AlertPopUp extends StatelessWidget {
  final String warningMessage;
  final String warningDescription;
  AlertPopUp({required this.warningMessage, required this.warningDescription});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: ErrorLottie(),
      content: Text(warningDescription),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ANLADIM'),
        ),
      ],
    );
  }
}
