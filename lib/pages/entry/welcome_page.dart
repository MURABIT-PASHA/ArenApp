import 'package:arenapp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:arenapp/components/welcome_text_action.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBody: true,
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            )),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                    height: 150.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                    padding: const EdgeInsets.all(5.0),
                    child: WelcomeTextAction()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
