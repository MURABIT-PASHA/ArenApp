import 'package:arenapp/ui/pages/entry/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:arenapp/ui/pages/entry/onboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        });
  }
}
