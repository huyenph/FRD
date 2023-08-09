import 'package:frd/blocs/app_bloc.dart';
import 'package:frd/core/constants.dart';
import 'package:frd/data/datasource/local/boxes.dart';
import 'package:frd/data/datasource/local/entities/config_entity.dart';
import 'package:frd/data/datasource/local/entities/language_entity.dart';
import 'package:frd/domain/repositories/app_repositoy.dart';

class AppRepositoryImpl extends AppRepository {
  AppRepositoryImpl();

  @override
  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageEntity? language,
  }) async {
    try {
      var configBox = Boxes.getAppConfig();
      if (configBox.length > 0) {
        ConfigEntity? config = configBox.getAt(0);
        if (config != null) {
          if (type == AppConfigType.theme) {
            config.theme = theme!;
          } else if (type == AppConfigType.locale) {
            config.language = language!;
          }
          config.save();
        }
      } else {
        configBox.add(ConfigEntity(
          theme: lightTheme,
          language: LanguageEntity(
            title: 'English',
            locale: 'en',
            subTitle: 'English',
          ),
        ));
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
