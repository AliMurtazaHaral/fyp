import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNav {
  String title;
  IconData icon;
  Color? color;
  bool badge = false;
  String badgeText = "";
  var navigation;

  BottomNav(this.title, this.icon, this.color, this.navigation);
  BottomNav.count(this.title, this.icon, this.color, this.badge, this.badgeText,
      this.navigation);
}
