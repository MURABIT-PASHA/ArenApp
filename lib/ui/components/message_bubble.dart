import 'package:arenapp/ui/components/received_message_screen.dart';
import 'package:arenapp/ui/components/sent_message_screen.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String prompt;
  final int number;
  final int dateHour;
  final int dateMinute;
  const MessageBubble(
      {required this.prompt, required this.number, required this.dateHour, required this.dateMinute});

  @override
  Widget build(BuildContext context) {
    switch (number) {
      case 0:
        return Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 30),
              ReceivedMessageScreen(message: prompt, dateHour: dateHour,dateMinute: dateMinute),
            ],
          ),
        );
      case 1:
        return Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 30),
              SentMessageScreen(message: prompt, dateHour: dateHour,dateMinute: dateMinute),
            ],
          ),
        );
      default:
        return Center(child: Text('Mistaken'),);
    }
  }
}
