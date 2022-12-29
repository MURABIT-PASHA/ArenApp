import 'package:arenapp/components/constants.dart';
import 'package:arenapp/components/navigation_drawer.dart';
import 'package:arenapp/components/rounded_button.dart';
import 'package:arenapp/pages/progress/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String itemName = "Conversation";
  final itemHint = "Add your conversation name";
  List itemList = [];

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
            title: Text(
              "ArenApp",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'UbuntuMono',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: Color(0xFF0E1937),
          ),
          body: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = itemList[index];
              return Dismissible(
                key: Key(item),
                background: Container(
                  color: Colors.red,
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 75,
                    ),
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    itemList.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Conversation removed")));
                },
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChatPage(title: itemList[index])));
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
                                itemList[index],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                '0 messages',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButton: RoundedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (builder) => Dialog(
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: MediaQuery.of(context).size.height -200,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextField(
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: itemHint,
                                  ),
                                  onChanged: (value) {
                                      itemName = value;
                                  },
                                ),
                                RoundedButton(
                                    colour: Colors.black54,
                                    buttonTitle: 'Create',
                                    onPressed: () {
                                      setState(() {
                                        itemList.add(itemName);
                                      });
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            colour: Colors.black12,
            buttonTitle: 'Create New Conversation',
          ),
        ),
      ),
    );
  }
}
