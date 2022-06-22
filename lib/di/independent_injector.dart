part of injector_setup;

void setupIndependent() {
  injector.registerSingleton<SharedPreferencesManager>(
    SharedPreferencesManager(),
  );
  injector.registerSingleton<TokenExpiredHandler>(
    TokenExpiredHandler(),
  );
  injector.registerSingleton<DatabaseHelper>(
    DatabaseHelper.instance,
  );
}
