import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';

class Navigation {
  late GlobalKey<NavigatorState> navigationKey;

  static final Navigation instance = Navigation();

  Navigation() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String routeName, {Object? args}) {
    return _safeNavigation(() => navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: args));
  }

  Future<dynamic> pushAndRemoveUntil(String routeName, {Object? args}) {
    return _safeNavigation(() => navigationKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false, arguments: args));
  }

  Future<dynamic> navigateTo(String routeName, {Object? args, Function(dynamic)? onReturn, }) {
    return _safeNavigation(() => navigationKey.currentState!
        .pushNamed(routeName, arguments: args)
        .then((result) {
      if (onReturn != null) {
        onReturn(result);
      }
    }));
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute routeName) {
    return _safeNavigation(() => navigationKey.currentState!.push(routeName));
  }

  void pushBack() {
    if (canPop()) {
      navigationKey.currentState!.pop();
    }
  }

  bool canPop() {
    return navigationKey.currentState!.canPop();
  }

  // Helper method to safely execute navigation methods
  Future<dynamic> _safeNavigation(Future<dynamic> Function() action) async {
    if (navigationKey.currentState == null) {
      throw Exception("Navigation state is null. Ensure the navigator key is properly initialized.");
    }
    return await action();
  }
}
