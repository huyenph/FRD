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

  Future<dynamic> removeAllUntil(String routeName, {dynamic arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
      );
    }
    return Future.value(null);
  }

  void popUntil(int routeCount) {
    if (navigatorKey.currentState != null) {
      int count = 0;
      return navigatorKey.currentState!.popUntil((_) => count++ == routeCount);
    }
  }

  void goBack() {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pop();
    }
  }

  bool canBack() {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.canPop();
    }
    return false;
  }
}
