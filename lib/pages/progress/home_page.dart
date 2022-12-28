import 'package:arenapp/components/navigation_drawer.dart';
import 'package:arenapp/data/dbms/chat_database_manager.dart';
import 'package:flutter/material.dart';
import 'models/conversation_info_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _chatDatabaseManager = ChatDatabaseManager.instance;
  late Future<List<dynamic>> _conversationNamesFuture;

  @override
  void initState() {
    super.initState();
    _conversationNamesFuture = _chatDatabaseManager.init().then((_) {
      return _chatDatabaseManager.getAllTableNames();
    });
  }

  @override
  void dispose() {
    _chatDatabaseManager.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
          drawer: NavigationDrawer(),
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 20.0,
            shadowColor: Colors.black54,
            title: Text("ArenApp", style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'UbuntuMono',
                fontWeight: FontWeight.bold,
                color: Colors.white),),
            backgroundColor: Color(0xFF0E1937),
          ),
          body: FutureBuilder<List<dynamic>>(
            future: _conversationNamesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ConversationInfo(
                        conversationName: snapshot.data![index],
                        chatDatabaseManager: _chatDatabaseManager,
                      );
                    },
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text("You have not conversation yet."),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text("An error occurred: ${snapshot.error}"),
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          floatingActionButton: Card(
            child: TextButton(
              onPressed: () async {
                await _chatDatabaseManager.createTableWithTimestamp();
                setState((){
                  _conversationNamesFuture =
                      _chatDatabaseManager.getAllTableNames();
                });
              },
              child: Text("Create New Conversation"),
            ),
          ),
        ),
      ),
    );
  }
}
