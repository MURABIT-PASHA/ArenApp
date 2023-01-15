import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardWidget extends StatelessWidget {
  OnboardWidget(
      {
      required this.urlImage,
      required this.title,
      required this.subtitle});
  final String urlImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: 50),
        color: Color(0xFF0E1937),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(
                urlImage,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 10.0),
              child: Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
