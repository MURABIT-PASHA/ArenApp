import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
class LoadingLottie extends StatelessWidget {
  const LoadingLottie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/jsons/loader.json'),
    );
  }
}
