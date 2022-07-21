import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:upm/core/navigation/navigation_service.dart';
import 'package:upm/core/navigation/route_generator.dart';
import 'package:upm/configs/theme/app_theme.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/screens/splash_screen.dart';

class UpmApp extends StatelessWidget {
  const UpmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: injector<NavigationService>().navigatorKey,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const SplashScreen(),
    );
  }
}
