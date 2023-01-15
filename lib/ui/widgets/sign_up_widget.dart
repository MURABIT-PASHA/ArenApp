import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../components/constants.dart';
import '../pages/entry/provider/google_sign.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _auth = FirebaseAuth.instance;
  double _logoSize = 100;
  final Curve _curve = Curves.easeInOut;
  String _email = "";
  String _password = "";
  bool _showPassword = false;
  bool _isLoginPage = false;
  bool _control() {
    if (_email != "" && _password != "")
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 50, 20, 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: [
              AnimatedContainer(
                width: _logoSize,
                height: _logoSize,
                duration: const Duration(seconds: 2),
                curve: _curve,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"))),
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: kTextFieldDecoration.copyWith(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: 'Type your mail address',
                  filled: true,
                  fillColor: Colors.green,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    hintText: 'Type your password',
                    filled: true,
                    fillColor: Colors.green,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(_showPassword
                          ? Icons.remove_red_eye_rounded
                          : Icons.remove_red_eye_outlined),
                      color: Colors.grey,
                    )),
                obscureText: _showPassword,
              ),
              SizedBox(
                height: 25,
              ),
              _isLoginPage
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () async {
                        if (_control()) {
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: _email, password: _password);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("User mail or password is wrong")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please fill all blanks")));
                        }
                      },
                      child: Text("Log In"))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () async {
                        if (_control()) {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: _email, password: _password);
                            await _auth.signInWithEmailAndPassword(
                                email: _email, password: _password);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Already have an user")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please fill all blanks")));
                        }
                      },
                      child: Text("Sign Up")),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Or Sign In with",
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Sign Up with Google Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: CircleBorder(),
                ),
                onPressed: () async {
                  setState(() {
                    _logoSize = 150;
                  });
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.googleLogin();
                },
                child: SvgPicture.asset('assets/icons/google.svg',
                    semanticsLabel: 'Google Logo'),
              ),
              Visibility(
                visible: !_isLoginPage,
                child: RichText(
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(color: Colors.black45)),
                      WidgetSpan(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoginPage = true;
                              });
                            },
                            child: const Text("Log in"),
                          ),
                          alignment: PlaceholderAlignment.middle)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
