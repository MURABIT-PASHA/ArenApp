import 'package:flutter/material.dart';
import '../chat_page.dart';

class ConversationInfo extends StatefulWidget {
  const ConversationInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<ConversationInfo> createState() => _ConversationInfoState();
}

class _ConversationInfoState extends State<ConversationInfo> {
  bool deleteSection = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        setState(() {
          deleteSection = !deleteSection;
        });
      },
      onTap: () {
        if (deleteSection) Navigator.pushNamed(context, ChatPage.id);
      },
      child: deleteSection
          ? Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GroupName',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        'Last Message Sender: Last Message...',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        'Last Message Sent Time',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      //TODO: Add delete the conversation here
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      color: Colors.red.shade900,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
