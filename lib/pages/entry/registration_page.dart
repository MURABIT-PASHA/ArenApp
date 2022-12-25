import 'package:arenapp/components/alert_dialog.dart';
import 'package:arenapp/components/rounded_button.dart';
import 'package:arenapp/components/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../progress/home_page.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final String tempEmail = '@arena.com';
  late String email;
  late String password;
  bool _visibility = true;
  IconData _iconData = Icons.visibility;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{  print('BackButtonPressed'); return true;},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: kBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Kurumsal mail adresinizi giriniz',
                  suffixText: '@arena.com',
                  suffixStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF297739)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF297739), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                keyboardType: TextInputType.number,
                obscureText: _visibility,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Size özel şifrenizi giriniz',
                  filled: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      changePasswordVisibility();
                    },
                    child: Icon(
                      _iconData,
                      color: Colors.white70,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF297739)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF297739), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Color(0xFF297739),
                buttonTitle: 'Kayıt Ol',
                onPressed: () async {
                  if (!email.contains('@arena.com')) {
                    email += tempEmail;
                  }
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser.user != null) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('userMailAddress', email);
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                  } catch (e) {
                    await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertPopUp(
                              warningMessage: 'HATALI GİRİŞ!',
                              warningDescription: 'Kullanıcı adı hatalı');
                        });
                    print(email);
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  changePasswordVisibility() {
    if (_visibility == true) {
      setState(() {
        _visibility = false;
        _iconData = Icons.visibility_off;
      });
    } else {
      setState(() {
        _visibility = true;
        _iconData = Icons.visibility;
      });
    }
  }
}
