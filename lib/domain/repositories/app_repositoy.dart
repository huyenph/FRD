import 'package:frd/blocs/app_bloc.dart';
import 'package:frd/data/datasource/local/entities/language_entity.dart';

abstract class AppRepository {
  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageEntity? language,
  });
}
