import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upm/blocs/app_bloc.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/core/navigation/navigation_service.dart';
import 'package:upm/core/navigation/route_generator.dart';
import 'package:upm/configs/theme/app_theme.dart';
import 'package:upm/data/datasource/local/boxes.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/domain/models/config_model.dart';
import 'package:upm/domain/usecases/app_usecase.dart';
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
    return BlocProvider(
      create: (_) => AppBloc(injector<AppUseCase>())
        ..add(const OnAppConfigEvent(AppConfigType.all)),
      child: ValueListenableBuilder<Box<ConfigModel>>(
        valueListenable: Boxes.getConfig().listenable(),
        builder: (context, box, _) {
          final ConfigModel config = box.values.last;
          return MaterialApp(
            navigatorKey: injector<NavigationService>().navigatorKey,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(config.language.locale),
            theme: config.theme == lightTheme ? AppTheme.light : AppTheme.dark,
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
