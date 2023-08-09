import 'package:hive/hive.dart';
import 'package:frd/data/datasource/local/entities/language_entity.dart';

part 'config_entity.g.dart';

@HiveType(typeId: 0)
class ConfigEntity extends HiveObject {
  ConfigEntity({
    required this.theme,
    required this.language,
  });

  @HiveField(0)
  String theme;
  @HiveField(1)
  LanguageEntity language;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigEntity &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          language == other.language;

  @override
  int get hashCode => theme.hashCode ^ language.hashCode;

  ConfigEntity copyWith({
    String? theme,
    LanguageEntity? language,
  }) {
    return ConfigEntity(
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }

  ConfigEntity.fromJson(Map<String, dynamic> json)
      : theme = json['theme'],
        language = LanguageEntity.fromJson(json['language']);

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'language': language.toJson(),
    };
  }
}
