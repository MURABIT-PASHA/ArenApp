import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
class ReceivedMessageScreen extends StatelessWidget {
  final String message;
  final int dateHour;
  final int dateMinute;
  const ReceivedMessageScreen(
      {required this.message, required this.dateHour,required this.dateMinute});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(message,textStyle: TextStyle(color: Colors.cyan.shade900, fontSize: 14),textAlign: TextAlign.left,speed: Duration(milliseconds: 50)),
                  ],
                ),
                Text(
                  '$dateHour:$dateMinute',
                  style: TextStyle(color: Colors.cyan.shade900, fontSize: 10),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
