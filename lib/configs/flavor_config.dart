enum Flavor { dev, stag, prod }

const String prodApiUrl = "";
const String stagApiUrl = "";
const String devApiUrl = "";

class FlavorValues {
  final String baseUrl;

  const FlavorValues({required this.baseUrl});
}

class FlavorConfig {
  final Flavor flavor;

  static FlavorConfig? _instance;

  static FlavorConfig? get instance => _instance;

  FlavorConfig._internal(this.flavor);

  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(flavor);
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
