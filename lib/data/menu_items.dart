import 'package:flutter/material.dart';
import 'package:arenapp/model/menu_item.dart';

class MenuItems {
  static const List<MenuComponent> itemsFirst = [
    itemSettings,
  ];
  static const List<MenuComponent> itemsLast = [
    itemSignOut,
  ];
  static const itemSettings =
      MenuComponent(text: 'Ayarlar', icon: Icons.settings);
  static const itemSignOut =
      MenuComponent(text: 'Çıkış Yap', icon: Icons.logout);
}
