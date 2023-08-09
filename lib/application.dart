import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frd/blocs/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frd/core/navigation/navigation_service.dart';
import 'package:frd/di/injector_setup.dart';
import 'package:frd/generated/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frd/data/datasource/local/entities/config_entity.dart';
import 'package:frd/data/datasource/local/boxes.dart';
import 'package:frd/core/navigation/route_generator.dart';
import 'package:frd/core/theme/app_theme.dart';
import 'package:frd/core/constants.dart';
import 'package:frd/domain/usecases/app_usecase.dart';
import 'package:frd/presentation/screens/splash_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider(
      create: (_) => AppBloc(injector<AppUseCase>())
        ..add(const OnAppConfigChangeRequested(AppConfigType.all)),
      child: ValueListenableBuilder<Box<ConfigEntity>>(
        valueListenable: Boxes.getAppConfig().listenable(),
        builder: (context, box, _) {
          final ConfigEntity? config =
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
