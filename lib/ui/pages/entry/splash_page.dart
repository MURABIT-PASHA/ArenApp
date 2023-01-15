import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/constants.dart';
import '../../components/welcome_text_action.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'welcome_screen';

  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
