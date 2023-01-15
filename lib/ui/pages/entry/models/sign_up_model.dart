import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  double _logoSize = 100;
  final Curve _curve = Curves.easeInOut;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedContainer(
                width: _logoSize,
                height: _logoSize,
                duration: const Duration(seconds: 2),
                curve: _curve,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/logo.png"))
                ),
              ),
              // Sign Up with Google Button
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white70),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _logoSize = 150;
                  });
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                child: RichText(
                  text: const TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                          alignment: PlaceholderAlignment.middle),
                      WidgetSpan(
                          child: SizedBox(
                        width: 10,
                      )),
                      TextSpan(text: "Sign in with Google", style: TextStyle(color: Colors.black45))
                    ],
                  ),
                ),
              ),
              // Login Text
              RichText(
                textDirection: TextDirection.ltr,
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'Already have an account?', style: TextStyle(color: Colors.black45)),
                    WidgetSpan(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Log in"),
                        ),
                        alignment: PlaceholderAlignment.middle)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
