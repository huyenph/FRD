part of injector_setup;

void setupDependent() {
  injector.registerSingleton<HttpHandler>(HttpHandler(injector()));
  injector.registerSingleton<RestApiFactoryListener>(injector());
}
