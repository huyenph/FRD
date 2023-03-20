import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hpcompose/common/utils.dart';
import 'package:hpcompose/configs/app_configs.dart';
import 'package:hpcompose/core/application_observer.dart';
import 'package:hpcompose/data/datasource/local/boxes.dart';
import 'package:hpcompose/di/injector_setup.dart';
import 'package:hpcompose/frd_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig(flavor: Flavor.dev);
  await initializeDependencies();
  await Boxes.init();
  appLogging();
  BlocOverrides.runZoned(
    () => runApp(const FrdApp()),
    blocObserver: ApplicationObserver(),
  );
}
