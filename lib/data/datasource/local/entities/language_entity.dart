import 'package:hive/hive.dart';

part 'language_entity.g.dart';

@HiveType(typeId: 1)
class LanguageEntity extends HiveObject {
  LanguageEntity({
    required this.title,
    required this.locale,
    this.subTitle,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String locale;
  @HiveField(2)
  String? subTitle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          locale == other.locale &&
          subTitle == other.subTitle;

  @override
  int get hashCode => title.hashCode ^ locale.hashCode ^ subTitle.hashCode;

  LanguageEntity copyWith({
    String? title,
    String? locale,
    String? subTitle,
  }) {
    return LanguageEntity(
      title: title ?? this.title,
      locale: locale ?? this.locale,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  factory LanguageEntity.fromJson(Map<String, dynamic> json) => LanguageEntity(
        title: json['title'],
        locale: json['locale'],
        subTitle: json['subTitle'] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'locale': locale,
      'subTitle': subTitle,
    };
  }
}
