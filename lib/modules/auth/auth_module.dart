part of '../../di/injector_setup.dart';

void authModule() {
  injector.registerSingleton<AuthService>(AuthService());

  injector.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(injector<AuthService>()),
  );

  injector.registerSingleton<AuthUseCase>(
    AuthUseCase(injector<AuthRepository>()),
  );
}
