import 'package:upm/blocs/app_bloc.dart';
import 'package:upm/domain/models/config_model.dart';
import 'package:upm/domain/models/language_model.dart';

abstract class AppRepository {
  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageModel? language,
  });
}
