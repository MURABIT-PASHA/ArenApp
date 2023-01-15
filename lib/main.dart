import 'package:arenapp/ui/pages/entry/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:arenapp/ui/pages/entry/onboard_page.dart';

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
        initialRoute: SplashPage.id,
        routes: {
          SplashPage.id: (context) => const SplashPage(),
          OnboardPage.id: (context) => const OnboardPage(),
        });
  }
}
