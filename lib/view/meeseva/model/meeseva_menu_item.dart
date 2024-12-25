import 'package:flutter/material.dart';

class MeesevaMenuItem {
  final String title;
  final IconData iconAsset;
  final Color cardColor;
  final String routeName;

  MeesevaMenuItem(
      {required this.title,
        required this.iconAsset,
        required this.cardColor,
        required this.routeName});
}
