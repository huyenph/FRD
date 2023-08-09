import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frd/core/navigation/navigation_service.dart';
import 'package:frd/di/injector_setup.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  _handleNotification(message);
}

void _handleNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'ic_stat_ic_notification',
        ),
        iOS: DarwinNotificationDetails(
            presentAlert: true,
            badgeNumber: 1,
            presentBadge: true,
            presentSound: true,
            subtitle: channel.description),
      ),
    );
  }
}

class FirebaseFCM {
  FirebaseFCM();

  late FirebaseMessaging _messaging;

  void registerNotification() async {
    // Initialize the Firebase hpcompose
    await Firebase.initializeApp();

    // Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _messaging.getToken().then((value) {
      print(value);
      _messaging.subscribeToTopic('hpcompose');
    });

    // On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Update the iOS foreground notification presentation options to allow
      // heads up notifications.
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Handle open hpcompose when terminated
      _messaging.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          injector<NavigationService>().navigateTo(
            '/home',
            arguments: message,
          );
          // Navigator.pushNamed(context, '/home', arguments: message);
        }
      });

      // For handling the received notifications in hpcompose
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleNotification(message);
        injector<NavigationService>().navigateTo(
          '/task',
          arguments: message,
        );

        // Navigator.pushNamed(context, '/task', arguments: message);
      });

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Handle open hpcompose when background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
        if (message != null) {
          injector<NavigationService>().navigateTo(
            '/settings',
            arguments: message,
          );

          // Navigator.pushNamed(context, '/settings', arguments: message);
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
