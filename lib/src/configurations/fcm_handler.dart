import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:rxdart/rxdart.dart';

class FCMHandler {
  static final BehaviorSubject<RemoteMessage> _messageStreamController =
      BehaviorSubject<RemoteMessage>();

  static Future<void> initializeFCM() async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

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
    } catch (e) {
      // Handle Firebase initialization error
      print('Firebase initialization failed: $e');
    }
  }

  static void setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  }

  static void setupBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    try {
      await Firebase.initializeApp();

      log('---firebaseMessagingBackgroundHandler----');

      if (kDebugMode) {
        print("Handling a background message: ${message.messageId}");
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }
    } catch (e) {
      // Handle Firebase initialization error
      print('Firebase initialization failed: $e');
    }
  }

  static Stream<RemoteMessage> get messageStream =>
      _messageStreamController.stream;

  static void dispose() {
    _messageStreamController.close();
  }
}
