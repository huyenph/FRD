import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frd/core/constants.dart';
import 'package:frd/data/datasource/local/entities/config_entity.dart';
import 'package:frd/data/datasource/local/entities/language_entity.dart';

class Boxes {
  static init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Hive
      ..init(appDocPath)
      ..registerAdapter(LanguageEntityAdapter())
      ..registerAdapter(ConfigEntityAdapter());
    await Hive.openBox<ConfigEntity>(boxAppConfig);
  }

  static Box<ConfigEntity> getAppConfig() =>
      Hive.box<ConfigEntity>(boxAppConfig);
}
