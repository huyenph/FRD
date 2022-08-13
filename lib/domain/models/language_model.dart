import 'package:hive/hive.dart';

part 'language_model.g.dart';

@HiveType(typeId: 1)
class LanguageModel extends HiveObject {
  LanguageModel({
    required this.name,
    required this.locale,
    this.subName,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String locale;
  @HiveField(2)
  String? subName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          locale == other.locale &&
          subName == other.subName;

  @override
  int get hashCode => name.hashCode ^ locale.hashCode ^ subName.hashCode;

  @override
  String toString() =>
      '{theme: "$name", locale: "$locale", description: "$subName"}';

  LanguageModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        locale = json['locale'],
        subName = json['subName'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'locale': locale,
      'subName': subName,
    };
  }
}
