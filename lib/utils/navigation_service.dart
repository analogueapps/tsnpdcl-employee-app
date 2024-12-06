import 'package:flutter/material.dart';

class Navigation {
  late GlobalKey<NavigatorState> navigationKey;

  static Navigation instance = Navigation();

  Navigation() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String routueName, {Object? args}) {
    return navigationKey.currentState!
        .pushReplacementNamed(routueName, arguments: args);
  }

  Future<dynamic> pushAndRemoveUntil(String routueName, {Object? args}) {
    return navigationKey.currentState!
        .pushNamedAndRemoveUntil(routueName, arguments: args, (route) => false);
  }

  Future<dynamic> navigateTo(String routueName, {Object? args, Function(dynamic)? onReturn}) {
    return navigationKey.currentState!
        .pushNamed(routueName, arguments: args)
        .then((result) {
          if (onReturn != null) {
            onReturn(result);
          }
        });
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute routueName) {
    return navigationKey.currentState!.push(routueName);
  }

  pushBack() {
    return navigationKey.currentState!.pop();
  }

  bool canPop() {
    return navigationKey.currentState!.canPop();
  }
}
