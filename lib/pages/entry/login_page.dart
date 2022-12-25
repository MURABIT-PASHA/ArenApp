import 'package:arenapp/components/alert_dialog.dart';
import 'package:arenapp/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../progress/home_page.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int numberOfRight = 3;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var txt = TextEditingController();
  String password = '';
  String email = '';

  @override
  void dispose() {
    //TODO implement to dispose
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    getUserMail();
  }

  Future<String> tryToGetName() async {
    try {
      final matchMail = await getUserMail();
      var _userName = "";
      await _firestore
          .collection('information')
          .doc(matchMail)
          .get()
          .then((value) => setState(() {
                _userName = value.data()!['name'];
                _userName += " ";
                _userName += value.data()!['surname'];
              }));
      return _userName;
    } catch (e) {
      return 'App Crashed';
    }
  }
  Future<String> getUserMail() async {
    final prefs = await SharedPreferences.getInstance();
    final tempMail = prefs.getString('userMailAddress') ?? 'defaultUser';
    email = tempMail;
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      extendBody: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                FutureBuilder(
                    future: tryToGetName(),
                    initialData: "Bir saniye lütfen...",
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      return SingleChildScrollView(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            text.requireData,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ));
                    }),
                TextField(
                    decoration: InputDecoration(
                        fillColor: kButtonColor,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        labelText: "ArenApp",
                        hintText: "Şifrenizi Giriniz",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    controller: txt,
                    onChanged: (String value) async {
                      password = value;
                      value = txt.text;
                      if (value.length < 6) {
                        return;
                      } else {
                        txt.text = '';
                        tryToReachUser();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void tryToReachUser() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id,(route) => false);
      }
    } catch (e) {
      //numberOfRight--;
      txt.text = '';
      AlertPopUp(
          warningMessage: 'HATALI GİRİŞ DENEMESİ',
          warningDescription: 'Kalan Deneme Hakkınız: $numberOfRight');
    }
  }

  bool textLocked() {
    if (numberOfRight == 0)
      return true;
    else
      return false;
  }
}
