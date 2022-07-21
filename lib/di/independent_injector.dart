part of injector_setup;

void setupIndependent() {
  injector.registerSingleton<SharedPreferencesManager>(
    SharedPreferencesManager(),
  );
  injector.registerSingleton<TokenExpiredHandler>(
    TokenExpiredHandler(),
  );
  injector.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );
  injector.registerLazySingleton(() => NavigationService());
  // injector.registerSingleton<AndroidNotificationChannel>(
  //   const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     description:
  //         'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   ),
  // );
  // injector.registerSingleton<FlutterLocalNotificationsPlugin>(
  //   FlutterLocalNotificationsPlugin(),
  // );
  // injector.registerLazySingletonAsync(() {
  //   /// Create an Android Notification Channel.
  //   ///
  //   /// We use this channel in the `AndroidManifest.xml` file to override the
  //   /// default FCM channel to enable heads up notifications.
  //   injector<FlutterLocalNotificationsPlugin>()
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(
  //         injector<AndroidNotificationChannel>(),
  //       );
  // });
}
