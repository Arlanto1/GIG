import 'dart:developer';
import 'dart:io';

import 'package:db_atom/index.dart';
import 'package:rxdart/rxdart.dart';

class FCMHandler {
  static final BehaviorSubject<RemoteMessage> _messageStreamController =
      BehaviorSubject<RemoteMessage>();

  static Future<void> initializeFCM() async {
    try {
      if (Platform.isAndroid) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } else if (Platform.isIOS) {
        await Firebase.initializeApp();
      }
      final messaging = FirebaseMessaging.instance;
      await messaging.setAutoInitEnabled(true);

      log('-will ask permission now-----');
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
        log('Permission granted: ${settings.authorizationStatus}');
      }

      String? token = await messaging.getToken();
      SharedPrefs.setDeviceToken(token??'');

      if (kDebugMode) {
        log('Registration Token=$token');
      }
    } catch (e) {
      // Handle Firebase initialization error
      log('Firebase initialization failed: $e');
    }
  }

  static void setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    if (kDebugMode) {
      log('Handling a foreground message: ${message.messageId}');
      log('Message data: ${message.data}');
      log('Message notification: ${message.notification?.title}');
      log('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  }

  static void setupBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('---message.notification?.title----${message.notification?.title}---');

    try {
      await Firebase.initializeApp();

      log('---firebaseMessagingBackgroundHandler----');

      if (kDebugMode) {
        log("Handling a background message: ${message.messageId}");
        log('Message data: ${message.data}');
        log('Message notification: ${message.notification?.title}');
        log('Message notification: ${message.notification?.body}');
      }
    } catch (e) {
      // Handle Firebase initialization error
      log('Firebase initialization failed: $e');
    }
  }

  static Stream<RemoteMessage> get messageStream =>
      _messageStreamController.stream;

  static void dispose() {
    _messageStreamController.close();
  }
}
