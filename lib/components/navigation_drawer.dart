import 'package:arenapp/components/constants.dart';
import 'package:arenapp/data/updates.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/entry/registration_page.dart';
import '../pages/progress/settings_page.dart';

class NavigationDrawer extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
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
            const SizedBox(height: 48.0,),
            buildMenuItem(text: 'Ayarlar', icon: Icons.settings,onClicked: ()=> selectedItem(context,0)),
            const SizedBox(height: 16.0,),
            buildMenuItem(text: 'Güncellemeler', icon: Icons.update,onClicked: ()=> selectedItem(context,1)),
            const SizedBox(height: 24.0,),
            Divider(color: Colors.white70,),
            const SizedBox(height: 16.0,),
            buildMenuItem(text: 'Çıkış Yap', icon: Icons.logout,onClicked: ()=> selectedItem(context,2)),
          ],
        ),
      ),
    );
  }
  Widget buildMenuItem({
  required String text,
    required IconData icon,
    VoidCallback? onClicked,
}){
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon,color: color,),
      title: Text(text, style: TextStyle(color: color),),
      hoverColor: hoverColor,
      onTap: onClicked,

    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.pushNamed(context, SettingsPage.id);
        break;
      case 1:
        Navigator.pushNamed(context, UpdatePage.id);
        break;
      case 2:
        getSignOut();
        _auth.signOut();
        Navigator.pushNamed(context, RegistrationScreen.id);
        break;
    }
  }
  //
  Future<void> getSignOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userMailAddress', 'defaultUser');
  }


}
