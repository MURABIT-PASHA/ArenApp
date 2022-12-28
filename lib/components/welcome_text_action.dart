import 'package:arenapp/pages/entry/onboard_page.dart';
import 'package:arenapp/pages/progress/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeTextAction extends StatefulWidget {
  const WelcomeTextAction({Key? key}) : super(key: key);

  @override
  State<WelcomeTextAction> createState() => _WelcomeTextActionState();
}

class _WelcomeTextActionState extends State<WelcomeTextAction> {
  late Widget screen;

  Future<Widget> getPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;
    if(showHome){
     return HomePage();
    }
    else{
      return OnboardPage();
    }
  }
  void getScreen()async{
    screen = await getPreferences();
    setState(() {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>screen), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 40.0,
          fontFamily: 'UbuntuMono',
          fontWeight: FontWeight.bold,

        ),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          onFinished: (){
            getScreen();
          },
          animatedTexts: [
            TypewriterAnimatedText(' ArenApp',textAlign: TextAlign.center,speed: Duration(milliseconds: 200)),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
