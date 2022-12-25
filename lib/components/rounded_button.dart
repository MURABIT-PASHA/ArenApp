import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.colour,required this.buttonTitle, required this.onPressed});
  final Color colour;
  final String buttonTitle;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15.0)),
            backgroundColor: MaterialStateColor.resolveWith((states) => colour),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: colour)))),
        onPressed: (){
          onPressed();
        },
        child: Text(
          buttonTitle,
        ),
      ),
    );
  }
}
