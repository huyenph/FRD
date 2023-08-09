import 'package:frd/blocs/app_bloc.dart';
import 'package:frd/data/datasource/local/entities/language_entity.dart';
import 'package:frd/domain/repositories/app_repositoy.dart';

class AppUseCase {
  const AppUseCase(this._appRepository);

  final AppRepository _appRepository;

  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageEntity? language,
  }) =>
      _appRepository.updateAppConfig(
        type,
        theme: theme,
        language: language,
      );
}
