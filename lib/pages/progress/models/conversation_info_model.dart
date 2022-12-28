import 'package:arenapp/data/model/conversation.dart';
import 'package:flutter/material.dart';
import '../../../data/dbms/chat_database_manager.dart';
import '../chat_page.dart';

class ConversationInfo extends StatefulWidget {
  final String conversationName;
  final ChatDatabaseManager chatDatabaseManager;
  const ConversationInfo({
    required this.conversationName,
    Key? key,
    required this.chatDatabaseManager,
  }) : super(key: key);

  @override
  State<ConversationInfo> createState() => _ConversationInfoState();
}

class _ConversationInfoState extends State<ConversationInfo> {
  List<Conversation> conversations = [];
  late Future<List<Conversation>> _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _conversationsFuture =
        widget.chatDatabaseManager.getAllFromTable(widget.conversationName);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.conversationName),
      background: Container(color: Colors.red, child: Center(child: Icon(Icons.delete,color: Colors.white,size: 75,),),),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await widget.chatDatabaseManager.dropTable(widget.conversationName);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Conversation removed")));
      },
      child: FutureBuilder<List<Conversation>>(
          future: _conversationsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              conversations = snapshot.data!;
              return Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                                ChatPage(conversations: conversations, chatDatabase: widget.chatDatabaseManager, conversationName: widget.conversationName,)));
                  },
                  child: Container(
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
                              'Conversation',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              '${conversations.length} messages',
                              style: TextStyle(color: Colors.white70),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text("Loading conversations..."),
                ),
              );
            }
          }),
    );
  }
}
