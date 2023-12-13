import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:rxdart/rxdart.dart';

class FCMHandler {
  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    final messaging = FirebaseMessaging.instance;
    await messaging.setAutoInitEnabled(true);

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }

    String? token = await messaging.getToken();

    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }

  static void setupForegroundMessageHandler() {
    final messageStreamController = BehaviorSubject<RemoteMessage>();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }

      messageStreamController.sink.add(message);
    });
  }

  static void setupBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    log('---firebaseMessagingBackgroundHandler----');

    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }
  }
}
