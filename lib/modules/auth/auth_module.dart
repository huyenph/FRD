part of injector_setup;

void authModule() {
  injector.registerSingleton<AuthService>(
    RestApiFactory(injector(), injector()).provideAuthService(),
  );

  injector.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      injector<AuthService>(),
      injector<SharedPreferencesManager>(),
    ),
  );

  injector.registerSingleton<AuthUseCase>(
    AuthUseCase(injector<AuthRepository>()),
  );
}
