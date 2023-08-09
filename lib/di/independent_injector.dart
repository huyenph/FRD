part of injector_setup;

void setupIndependent() {
  injector.registerLazySingleton(() => NavigationService());
  injector.registerSingleton<RestApiFactory>(RestApiFactory());
  injector.registerSingleton<Dio>(injector<RestApiFactory>().createDioClient());
  injector.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
}
