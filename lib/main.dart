import 'package:arenapp/data/updates.dart';
import 'package:arenapp/pages/progress/chat_page.dart';
import 'package:arenapp/pages/entry/login_page.dart';
import 'package:arenapp/pages/entry/registration_page.dart';
import 'package:arenapp/pages/entry/welcome_page.dart';
import 'package:arenapp/pages/progress/home_page.dart';
import 'package:arenapp/pages/progress/settings_page.dart';
import 'package:arenapp/pages/progress/square.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:arenapp/pages/entry/onboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(ArenApp());
}

class ArenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          OnboardPage.id: (context) => const OnboardPage(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          ChatPage.id: (context) => const ChatPage(),
          SettingsPage.id: (context) => const SettingsPage(),
          UpdatePage.id: (context) => const UpdatePage(),
          SquarePage.fromGallery: (context) => SquarePage(isGallery: true),
          SquarePage.fromCamera: (context) => SquarePage(isGallery: false)
        });
  }
}
