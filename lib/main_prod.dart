import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frd/application.dart';
import 'package:frd/configs/flavor_config.dart';
import 'package:frd/core/app_logger.dart';
import 'package:frd/data/datasource/local/boxes.dart';
import 'package:frd/data/datasource/remote/http_overrides.dart';
import 'package:frd/di/injector_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = FrdOverrides();
  FlavorConfig(flavor: Flavor.prod);
  initializeDependencies();
  await Boxes.init();
  AppLogger.logger;
  runApp(const Application());
}
