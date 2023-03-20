import 'package:hpcompose/blocs/app_bloc.dart';
import 'package:hpcompose/domain/models/language_model.dart';
import 'package:hpcompose/domain/repositories/app_repositoy.dart';

class AppUseCase {
  const AppUseCase(this._appRepository);

  final AppRepository _appRepository;

  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageModel? language,
  }) =>
      _appRepository.updateAppConfig(
        type,
        theme: theme,
        language: language,
      );
}
