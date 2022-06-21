import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/common/utils.dart';
import 'package:upm/configs/app_configs.dart';
import 'package:upm/core/application_observer.dart';
import 'package:upm/upm_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig(flavor: Flavor.prod);
  appLogging();
  BlocOverrides.runZoned(
    () => runApp(const UpmApp()),
    blocObserver: ApplicationObserver(),
  );
}
