import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20.0);
  bool isTurkish = false;
  String langName = "en_GB";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Material(
        color: kBackgroundColor,
        child: ListView(
          padding: padding,
          children: [
            const SizedBox(
              height: 48.0,
            ),
            SwitchListTile(
                title: Text("Turkish",style: TextStyle(fontFamily: "Poppins",color: Colors.white),),
                value: isTurkish, onChanged: (value){
            }),
            Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 16.0,
            ),
            buildMenuItem(
                text: 'Murabıt Akdoğan', icon: FontAwesomeIcons.linkedin, onClicked: () {}),
            Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 16.0,
            ),
            buildMenuItem(
                text: 'MURABIT-PASHA', icon: FontAwesomeIcons.github, onClicked: () {}),
            Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 16.0,
            ),
            buildMenuItem(
                text: 'Murabit The Magnificent', icon: FontAwesomeIcons.internetExplorer, onClicked: () {}),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color, fontFamily: "Poppins"),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
