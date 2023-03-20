import 'package:hpcompose/blocs/app_bloc.dart';
import 'package:hpcompose/common/constants.dart';
import 'package:hpcompose/data/datasource/local/boxes.dart';
import 'package:hpcompose/data/datasource/local/shared_preferences_manager.dart';
import 'package:hpcompose/domain/models/config_model.dart';
import 'package:hpcompose/domain/models/language_model.dart';
import 'package:hpcompose/domain/repositories/app_repositoy.dart';

class AppRepositoryImpl extends AppRepository {
  AppRepositoryImpl(this.prefs);

  final SharedPreferencesManager prefs;

  @override
  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageModel? language,
  }) async {
    try {
      var configBox = Boxes.getConfig();
      if (configBox.length > 0) {
        ConfigModel? config = configBox.getAt(0);
        if (config != null) {
          if (type == AppConfigType.theme) {
            config.theme = theme!;
          } else if (type == AppConfigType.locale) {
            config.language = language!;
          }
          config.save();
        }
      } else {
        configBox.add(ConfigModel(
          theme: lightTheme,
          language: LanguageModel(
            name: 'English',
            locale: 'en',
            subName: 'English',
          ),
        ));
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
