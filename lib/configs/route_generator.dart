import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upm/modules/auth/screens/auth_screen.dart';
import 'package:upm/modules/home/home_screen.dart';
import 'package:upm/modules/settings/setting_screen.dart';
import 'package:upm/modules/task/task_screen.dart';
import 'package:upm/presentation/screens/splash_screen.dart';

class RouteGenerator {
  static Route<Object> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case '/auth':
        return CupertinoPageRoute(builder: (_) => const AuthScreen());
      case '/home':
        return CupertinoPageRoute(
          builder: (_) => HomeScreen(
            message: settings.arguments as RemoteMessage,
          ),
        );
      case '/settings':
        return CupertinoPageRoute(
          builder: (_) => SettingScreen(
            message: settings.arguments as RemoteMessage,
          ),
        );
      case '/task':
        return CupertinoPageRoute(
          builder: (_) => TaskScreen(
            message: settings.arguments as RemoteMessage,
          ),
        );
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
