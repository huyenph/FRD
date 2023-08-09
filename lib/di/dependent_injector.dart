part of injector_setup;

void setupDependent() {
  injector.registerSingleton<AppRepository>(AppRepositoryImpl());
  injector.registerSingleton<AppUseCase>(AppUseCase(injector()));
}
