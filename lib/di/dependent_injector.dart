part of 'injector_setup.dart';

void setupDependent() {
  injector.registerSingleton<AppRepository>(AppRepositoryImpl());
  injector.registerSingleton<AppUseCase>(AppUseCase(injector()));
}
