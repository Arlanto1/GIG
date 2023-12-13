import 'dart:developer';

import 'package:db_atom/flavors.dart';
import 'package:db_atom/initialize_providers.dart';
import 'package:db_atom/main.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/localization/locale_supported.dart';
import 'package:db_atom/src/routing/route_generator.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/InactivityFunctions.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:db_atom/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
export 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainConfig with WidgetsBindingObserver {
  static environmentsChanging() {
    log('-environmentsChanging---main_config--');
    String environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: F.title == "DEV"
          ? Environment.DEV
          : F.title == "QA"
              ? Environment.QA
              : F.title == "UAT"
                  ? Environment.UAT
                  : Environment.PROD,
    );

    Environment().initConfig(environment);
  }

  static initialSetup(GlobalKey<NavigatorState> navigatorKey) async {
    log('-initialSetup---main_config--');
    Locale? locale;

    // Required for async calls in `main`
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize SharedPrefs instance.
    await SharedPrefs.init();

    // Environment setup
    environmentsChanging();

    // Listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(MainConfig());
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // TODO: Request permission
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
    // TODO: Register with FCM
    // It requests a registration token for sending messages to users from your App server or other trusted server environment.
    String? token = await messaging.getToken();

    if (kDebugMode) {
      print('Registration Token=$token');
    }

    // TODO: Set up foreground message handler
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


    // TODO: Set up background message handler
    Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();

      if (kDebugMode) {
        print("Handling a background message: ${message.messageId}");
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    runApp(
      InitializeProviders(
        child: MaterialApp(
          theme: ThemeData(
            disabledColor: AppColors.textgreyThemecolor,
            fontFamily: Constants.customFontFamily,
            primarySwatch: AppColors.colorCustom,
          ),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: splashScreenRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
          locale: locale,
          supportedLocales: LocaleSupportedMethod.supportedLocale,
          localizationsDelegates:
              LocaleSupportedMethod.getLocalizationsDelegates(),
          localeResolutionCallback: (locale, supportedLocales) =>
              LocaleSupportedMethod.getLocale(locale, supportedLocales),
          // Add a builder to wrap your MaterialApp with a GestureDetector
          builder: (context, child) {
            return GestureDetector(
              // Trigger updateUserInteraction whenever the user interacts with the app
              onTap: () => InactivityFunctions().updateUserInteraction(),
              child: child!,
            );
          },
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    log('--state------${state.toString()}--');

    switch (state) {
      case AppLifecycleState.paused:
        InactivityFunctions().updateUserInteraction();
        break;
      case AppLifecycleState.detached:
        log('--calling logout------${state.toString()}--');
        logout(navigatorKey);
        break;
      case AppLifecycleState.resumed:
        DateTime lastUserInteractionTime =
            await InactivityFunctions().getLastUserInteractionTime();
        if (InactivityFunctions().isTimeExceeded(
            lastUserInteractionTime, Constants.inactivityDuration)) {
          logout(navigatorKey);
        }
        break;
      default:
    }
  }

  static void logout(GlobalKey<NavigatorState> navigatorKey) {
    InactivityFunctions().logoutUser(navigatorKey);
  }
}
