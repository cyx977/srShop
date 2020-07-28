import 'package:flutter/material.dart';

class RouteData {
  final String title;
  final IconData icon;
  final bool addToMenu;
  final instance;
  const RouteData({
    @required this.title,
    @required this.icon,
    this.addToMenu = true,
    @required this.instance,
  });
}

class MenuButton {
  final String title;
  final IconData icon;
  final bool addToMenu;
  final Function onTap;
  const MenuButton({
    @required this.title,
    @required this.icon,
    @required this.onTap,
    this.addToMenu = true,
  });
}
