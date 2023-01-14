import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Mesajınızı buraya yazınız...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kLabelTextColor = Colors.white;
const kLabelTextColor1 = Colors.teal;
const kMainColor = Color(0xFF232D36);
kLabelTextStyle1(String text, Color colour) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 20.0,
        fontFamily: 'UbuntuMono',
        fontWeight: FontWeight.bold,
        color: colour),
    textAlign: TextAlign.center,
  );
}

kLabelTextStyle2(String text, Color colour) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 45.0,
        fontFamily: 'UbuntuMono',
        fontWeight: FontWeight.bold,
        color: colour),
    textAlign: TextAlign.center,
  );
}

const kBackgroundColor = Color(0xFF1F262E);
const kButtonColor = Color(0xFF252C34);
Widget kFloatButtonTextStyle2(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 30.0,
        fontFamily: 'UbuntuMono',
        fontWeight: FontWeight.bold,
        color: Colors.white),
    textAlign: TextAlign.center,
  );
}

Widget kAnimatedAppText(){
  return AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText('ArenApp',textStyle: TextStyle(
        fontSize: 45.0,
        fontFamily: 'UbuntuMono',
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade500,
      ),),
    ],
    isRepeatingAnimation: false,
  );
}

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const kPageOneColor = Color(0xFF29BFDF);
const kPageTwoColor = Color(0xFFFF614E);
const kPageThreeColor = Color(0xFFE29D17);
const kPageSkipTextColor = Color(0xFF26283C);