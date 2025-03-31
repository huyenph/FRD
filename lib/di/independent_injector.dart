part of 'injector_setup.dart';

void setupIndependent() {
  injector.registerLazySingleton(() => NavigationService());
  injector.registerSingleton<RestApiFactory>(RestApiFactory());
  injector.registerSingleton<Dio>(injector<RestApiFactory>().createDioClient());
  injector.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
}
