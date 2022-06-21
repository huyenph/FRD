enum Flavor { dev, stag, prod }

const String prodApiUrl = "";
const String stagApiUrl = "";
const String devApiUrl = "";

class FlavorValues {
  final String baseUrl;

  const FlavorValues({required this.baseUrl});
}

class AppConfig {
  final Flavor flavor;

  static AppConfig? _instance;

  static AppConfig? get instance => _instance;

  AppConfig._internal(this.flavor);

  factory AppConfig({required Flavor flavor}) {
    _instance ??= AppConfig._internal(flavor);
    return _instance!;
  }

  String get rootUrl {
    switch (_instance!.flavor) {
      case Flavor.prod:
        return prodApiUrl;
      case Flavor.stag:
        return stagApiUrl;
      case Flavor.dev:
        return devApiUrl;
    }
  }
}
