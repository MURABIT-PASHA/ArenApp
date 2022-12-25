import 'package:arenapp/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'models/conversation_info_model.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            //TODO: Create new conversation
          },child: Icon(Icons.chat, color: Colors.white,),backgroundColor: Color(0xFF0E1937),),
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
          body:ListView(
            //TODO: Convert this ListView to ListView.builder get elements from local database
                children: [
                  ConversationInfo(),
                ]
            ),
        ),
      ),
    );
  }
}


