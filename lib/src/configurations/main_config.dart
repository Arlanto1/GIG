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

    // Locale? locale;
    String initialRouteName = await initRouting();
    runApp(
      InitializeProviders(
        child: MaterialApp(
          theme: ThemeData(
            disabledColor: AppColors.textGreyThemeColor,
            fontFamily: Constants.customFontFamily,
            primarySwatch: AppColors.colorCustom,
          ),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRouteName,
          onGenerateRoute: RouteGenerator.generateRoute,
          // locale: locale,
          // supportedLocales: LocaleSupportedMethod.supportedLocale,
          // localizationsDelegates:
          //     LocaleSupportedMethod.getLocalizationsDelegates(),
          // localeResolutionCallback: (locale, supportedLocales) =>
          //     LocaleSupportedMethod.getLocale(locale, supportedLocales),
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

  static Future<String> initRouting() async {
    log('--initRouting---');
    // Get the NavigatorState object

    // Get the user name and token from SharedPrefs
    String userName = await SharedPrefs.getUserId();
    String token = await SharedPrefs.getToken();
    log('--initRouting-userName-$userName-');

    // Check if the user is logged in
    if (!userName.isEmptyOrNull && !token.isEmptyOrNull) {
      // Check if a password change is required
      bool requirePasswordChange =
          await SharedPrefs.getIsRequiredPasswordChange();

      // Navigate to the reset password screen if a password change is required
      if (requirePasswordChange) {
        log('--initRouting--resetPwdScreenRoute-');
        return resetPwdScreenRoute;
        // navigatorState.pushNamed(resetPwdScreenRoute);
        // return;
      }

      // Navigate to the dashboard screen and remove all previous screens from the back stack

      log('--initRouting--dashboardViewRoute-');
      return dashboardViewRoute;
    } else {
      log('--initRouting--loginScreenRoute-');
      // Navigate to the login screen and remove all previous screens from the back stack
      return loginScreenRoute;
    }
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
