import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorLottie extends StatelessWidget {
  const ErrorLottie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset('assets/jsons/error.json',repeat: false),
    );
  }
}
