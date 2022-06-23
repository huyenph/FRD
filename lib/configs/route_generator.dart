import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upm/presentation/screens/splash_screen.dart';

class RouteGenerator {
  static Route<Object> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case '/signin':
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<Object> _errorRoute() {
    return CupertinoPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('Oops!\nSomething went wrong.'),
              ),
            ));
  }

  @optionalTypeArgs
  static Future<T?> push<T extends Object>(
    BuildContext context,
    Route<T> route,
  ) {
    return Navigator.of(context).push(route);
  }

  @optionalTypeArgs
  static Future<T?> pushNamed<T extends Object>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }
}
