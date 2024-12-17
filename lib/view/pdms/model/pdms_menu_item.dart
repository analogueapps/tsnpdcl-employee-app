import 'package:flutter/material.dart';

class PdmsMenuItem {
  final String title;
  final IconData iconAsset;
  final Color cardColor;
  final String routeName;

  PdmsMenuItem(
      {required this.title,
        required this.iconAsset,
        required this.cardColor,
        required this.routeName});
}
