import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hpcompose/blocs/app_bloc.dart';
import 'package:hpcompose/common/constants.dart';
import 'package:hpcompose/core/navigation/navigation_service.dart';
import 'package:hpcompose/core/navigation/route_generator.dart';
import 'package:hpcompose/configs/theme/app_theme.dart';
import 'package:hpcompose/data/datasource/local/boxes.dart';
import 'package:hpcompose/di/injector_setup.dart';
import 'package:hpcompose/domain/models/config_model.dart';
import 'package:hpcompose/domain/usecases/app_usecase.dart';
import 'package:hpcompose/generated/l10n.dart';
import 'package:hpcompose/presentation/screens/splash_screen.dart';

class FrdApp extends StatelessWidget {
  const FrdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider(
      create: (_) => AppBloc(injector<AppUseCase>())
        ..add(const OnAppConfigEvent(AppConfigType.all)),
      child: ValueListenableBuilder<Box<ConfigModel>>(
        valueListenable: Boxes.getConfig().listenable(),
        builder: (context, box, _) {
          final ConfigModel? config =
              box.values.isNotEmpty ? box.values.last : null;
          return MaterialApp(
            navigatorKey: injector<NavigationService>().navigatorKey,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(config != null ? config.language.locale : enLocale),
            theme: config != null
                ? config.theme == lightTheme
                    ? AppTheme.light
                    : AppTheme.dark
                : AppTheme.light,
            darkTheme: AppTheme.dark,
            debugShowCheckedModeBanner: false,
            initialRoute: initRoute,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
