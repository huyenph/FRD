import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: arguments,
      );
    }
    return Future.value(null);
  }

  Future<dynamic> replaceTo(String routeName, {dynamic arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    }
    return Future.value(null);
  }

  void goBack() {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pop();
    }
  }
}
