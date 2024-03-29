part of injector_setup;

void authModule() {
  injector.registerSingleton<AuthService>(AuthService());

  injector.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      injector<AuthService>(),
    ),
  );

  injector.registerSingleton<AuthUseCase>(
    AuthUseCase(injector<AuthRepository>()),
  );
}
