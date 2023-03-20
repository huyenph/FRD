import 'package:hpcompose/blocs/app_bloc.dart';
import 'package:hpcompose/domain/models/language_model.dart';

abstract class AppRepository {
  Future<bool> updateAppConfig(
    AppConfigType type, {
    String? theme,
    LanguageModel? language,
  });
}
