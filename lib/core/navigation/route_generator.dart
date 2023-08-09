import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frd/core/constants.dart';
import 'package:frd/modules/auth/screens/auth_screen.dart';
import 'package:frd/modules/main/main_screen.dart';
import 'package:frd/modules/settings/language_screen.dart';
import 'package:frd/modules/settings/setting_screen.dart';
import 'package:frd/modules/task/task_screen.dart';
import 'package:frd/presentation/screens/splash_screen.dart';

class RouteGenerator {
  static Route<Object> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case authRoute:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            message: settings.arguments != null
                ? settings.arguments as RemoteMessage
                : null,
          ),
        );
      case settingRoute:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(
            message: settings.arguments as RemoteMessage,
          ),
        );
      case languageRoute:
        return MaterialPageRoute(
          builder: (_) => LanguageScreen(),
        );
      case '/task':
        return MaterialPageRoute(
          builder: (_) => TaskScreen(
            message: settings.arguments as RemoteMessage,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<Object> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('Oops!\nSomething went wrong.'),
              ),
            ));
  }
}
