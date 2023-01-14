import 'package:arenapp/ui/widgets/solution_widget.dart';
import 'package:flutter/material.dart';
import '../../components/navigation_drawer.dart';
import '../../components/rounded_button.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  ChatPage(title: itemList[index])));
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
              Navigator.push(context, MaterialPageRoute(builder: (builder) => SolutionForm()));
            },
            colour: Colors.black12,
            buttonTitle: 'Create Solution',
          ),
        ),
      ),
    );
  }
}
