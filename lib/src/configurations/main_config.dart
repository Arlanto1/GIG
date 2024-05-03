import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/utils/device_infomation.dart';

export 'package:flutter/material.dart';

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
    // try {
    //   await FCMHandler.initializeFCM();
    //   FCMHandler.setupForegroundMessageHandler();
    //   FCMHandler.setupBackgroundMessageHandler();
    // } catch (e) {
    //   // Handle Firebase initialization error
    //   log('Firebase initialization failed: $e');
    // }

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
    InactivityFunctions().startInactivityTimer(navigatorKey);
    DeviceInformation().initPlatformState();
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
            lastUserInteractionTime, Environment().config.inactivityDuration)) {
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
