import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hpcompose/common/constants.dart';
import 'package:hpcompose/domain/models/config_model.dart';
import 'package:hpcompose/domain/models/language_model.dart';

class Boxes {
  static init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Hive
      ..init(appDocPath)
      ..registerAdapter(ConfigModelAdapter())
      ..registerAdapter(LanguageModelAdapter());
    await Hive.openBox<ConfigModel>(boxConfig);
  }

  static Box<ConfigModel> getConfig() => Hive.box<ConfigModel>(boxConfig);
}
