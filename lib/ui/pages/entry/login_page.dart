import 'package:arenapp/ui/pages/progress/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arenapp/ui/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/sign_up_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SizedBox(height: 100, width: 100, child: CircularProgressIndicator(color: Colors.black38,)));
          }else if(snapshot.hasData){
            return const HomePage();
          }else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong, please try it later"));
          }else{
            return const SignUpWidget();
          }
        },),
    );
  }

}