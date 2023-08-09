import 'package:flutter/material.dart';
import 'package:frd/application.dart';
import 'package:frd/configs/app_configs.dart';
import 'package:frd/core/app_logger.dart';
import 'package:frd/data/datasource/local/boxes.dart';
import 'package:frd/di/injector_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig(flavor: Flavor.prod);
  initializeDependencies();
  await Boxes.init();
  AppLogger.logger;
  runApp(const Application());
}
