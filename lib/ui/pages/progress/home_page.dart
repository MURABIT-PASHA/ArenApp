import 'package:arenapp/ui/widgets/solution_form_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/navigation_drawer.dart';
import '../../components/rounded_button.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _userMail;
  final user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _userMail = (user.email)!;
    super.initState();
  }
  Widget _getSolutionPage(String type){
    switch(type){
      case "conText":
        return ChatPage();
      default:
        return Center();
    }
  }
  String _getSolutionDescription(String type){
    switch(type){
      case "conText":
        return "Conversation with AI";
      default:
        return "Error";
    }
  }

  Widget _getSolutionImage(String type){
    switch(type){
      case "conText":
        return SvgPicture.asset("assets/icons/text_solution.svg", color: Colors.red,);
      default:
        return Icon(Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
          drawer: CustomNavigationDrawer(),
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
          body: StreamBuilder<QuerySnapshot>(
            stream:
                _firestore.collection(_userMail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData == true) {
                final solutions = snapshot.data?.docs;
                List<dynamic> solutionList = [];
                for (var solution in solutions!) {
                  solutionList.add(solution);
                  print(solution.id);
                }
                return ListView.builder(
                  itemCount: solutionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = solutionList[index].id;
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
                      onDismissed: (direction) async {
                        try {
                          await _firestore
                              .collection(_userMail)
                              .doc(solutionList[index].id)
                              .delete();
                        } catch (e) {
                          print(e);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Solution removed")));
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            final solutionType =
                                solutionList[index].get('name');
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (builder) =>_getSolutionPage(solutionType)));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  child: _getSolutionImage(solutionList[index].get('name')),
                                  radius: 40.0,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getSolutionDescription(solutionList[index].get('name')),
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
                );
              } else {
                return Center();
              }
            },
          ),
          floatingActionButton: RoundedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => SolutionFormWidget()));
            },
            colour: Colors.black12,
            buttonTitle: 'Create Solution',
          ),
        ),
      ),
    );
  }
}
