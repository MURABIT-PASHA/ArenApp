import 'package:arenapp/ui/pages/entry/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../pages/entry/onboard_page.dart';
import '../pages/progress/home_page.dart';

class WelcomeTextAction extends StatefulWidget {
  const WelcomeTextAction({Key? key}) : super(key: key);

  @override
  State<WelcomeTextAction> createState() => _WelcomeTextActionState();
}

class _WelcomeTextActionState extends State<WelcomeTextAction> {
  late Widget screen;

  Future<bool> _isLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    final isLogged = prefs.getBool('isLogged') ?? false;
    return isLogged;
  }
  Future<bool> _isOnboardShowed() async{
    final prefs = await SharedPreferences.getInstance();
    final isShowed = prefs.getBool('isOnboardShowed') ?? false;
    return isShowed;
  }
  Future<Widget> _getPreferences() async{
    final bool isShowed = await _isOnboardShowed();
    final bool isLogged = await _isLoggedIn();
    if(isShowed){
      if(isLogged){
        return HomePage();
      }
      else{
        return LoginPage();
      }
    }
    else{
      return OnboardPage();
    }
  }
  void _getScreen()async{
    screen = await _getPreferences();
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
            _getScreen();
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
