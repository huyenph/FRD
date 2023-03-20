import 'package:hive/hive.dart';
import 'package:hpcompose/domain/models/language_model.dart';

part 'config_model.g.dart';

@HiveType(typeId: 0)
class ConfigModel extends HiveObject {
  ConfigModel({
    required this.theme,
    required this.language,
  });

  @HiveField(0)
  String theme;
  @HiveField(1)
  LanguageModel language;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigModel &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          language == other.language;

  @override
  int get hashCode => theme.hashCode ^ language.hashCode;

  @override
  String toString() => '{theme: $theme, language: ${language.toString()}}';

  set setTheme(String themeStr) {
    theme = themeStr;
  }

  set setLanguage(LanguageModel languageModel) {
    language = languageModel;
  }

  ConfigModel.fromJson(Map<String, dynamic> json)
      : theme = json['theme'],
        language = LanguageModel.fromJson(json['language']);

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'language': language.toJson(),
    };
  }
}
