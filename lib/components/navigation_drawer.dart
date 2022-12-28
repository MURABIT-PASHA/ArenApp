import 'package:arenapp/components/constants.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20.0);
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
            buildMenuItem(text: 'Mode', icon: Icons.settings, onClicked: () {}),
            const SizedBox(
              height: 16.0,
            ),
            Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 16.0,
            ),
            buildMenuItem(
                text: 'Language', icon: Icons.logout, onClicked: () {}),
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
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
