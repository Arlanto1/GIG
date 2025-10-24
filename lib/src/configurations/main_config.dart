// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/utils/device_infomation.dart';
// //
// // export 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // // import '../features/app_theme/themeController.dart';
// //
// //
// // class MainConfig with WidgetsBindingObserver {
// //   static environmentsChanging() {
// //     log('-environmentsChanging---main_config--');
// //     String environment = String.fromEnvironment(
// //       'ENVIRONMENT',
// //       defaultValue: F.title == "DEV"
// //           ? Environment.DEV
// //           : F.title == "QA"
// //               ? Environment.QA
// //               : F.title == "UAT"
// //                   ? Environment.UAT
// //                   : Environment.PROD,
// //     );
// //
// //     Environment().initConfig(environment);
// //   }
// //
// //   // static initialSetup(GlobalKey<NavigatorState> navigatorKey) async {
// //   //   log('-initialSetup---main_config--');
// //   //
// //   //   // Required for async calls in `main`
// //   //   WidgetsFlutterBinding.ensureInitialized();
// //   //
// //   //
// //   //   // Initialize SharedPrefs instance.
// //   //   try {
// //   //     await SharedPrefs.init();
// //   //   }
// //   //   catch(e){
// //   //     log('Not initialized');
// //   //   }
// //   //   // Environment setup
// //   //   environmentsChanging();
// //   //
// //   //   // Listen for app lifecycle changes
// //   //   WidgetsBinding.instance.addObserver(MainConfig());
// //   //
// //   //
// //   //   await Firebase.initializeApp(
// //   //       name: 'AtomEdge',
// //   //     options: DefaultFirebaseOptions.currentPlatform
// //   //   );
// //   //
// //   //   // Enable Crashlytics collection
// //   //   FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
// //   //
// //   //   // Pass all uncaught errors from the framework to Crashlytics
// //   //   FlutterError.onError = (errorDetails) {
// //   //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
// //   //   };
// //   //
// //   //   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
// //   //   PlatformDispatcher.instance.onError = (error, stack) {
// //   //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
// //   //     return true;
// //   //   };
// //   //   FirebaseCrashlytics.instance.log('Test: Flutter App started');
// //   //
// //   //   log('---Firebase.initializeApp----');
// //   //   // try {
// //   //   //   await FCMHandler.initializeFCM();
// //   //   //   FCMHandler.setupForegroundMessageHandler();
// //   //   //   FCMHandler.setupBackgroundMessageHandler();
// //   //   // } catch (e) {
// //   //   //   // Handle Firebase initialization error
// //   //   //   log('Firebase initialization failed: $e');
// //   //   // }
// //   //
// //   //   // Locale? locale;
// //   //   String initialRouteName = await initRouting();
// //   //   runApp(
// //   //     InitializeProviders(
// //   //       child: MaterialApp(
// //   //         theme: ThemeData(
// //   //           disabledColor: AppColors.textGreyThemeColor,
// //   //           fontFamily: Constants.customFontFamily,
// //   //           primarySwatch: AppColors.colorCustom,
// //   //         ),
// //   //         navigatorKey: navigatorKey,
// //   //         debugShowCheckedModeBanner: false,
// //   //         initialRoute: initialRouteName,
// //   //         onGenerateRoute: RouteGenerator.generateRoute,
// //   //         // locale: locale,
// //   //         // supportedLocales: LocaleSupportedMethod.supportedLocale,
// //   //         // localizationsDelegates:
// //   //         //     LocaleSupportedMethod.getLocalizationsDelegates(),
// //   //         // localeResolutionCallback: (locale, supportedLocales) =>
// //   //         //     LocaleSupportedMethod.getLocale(locale, supportedLocales),
// //   //         // Add a builder to wrap your MaterialApp with a GestureDetector
// //   //         builder: (context, child) {
// //   //           return GestureDetector(
// //   //             // Trigger updateUserInteraction whenever the user interacts with the app
// //   //             onTap: () => InactivityFunctions().updateUserInteraction(),
// //   //             child: child!,
// //   //           );
// //   //         },
// //   //       ),
// //   //     ),
// //   //   );
// //   //   InactivityFunctions().startInactivityTimer(navigatorKey);
// //   //   DeviceInformation().initPlatformState();
// //   // }
// //
// //   static Future<void> initialSetup(GlobalKey<NavigatorState> navigatorKey) async {
// //     log('-initialSetup---main_config--');
// //
// //     // Ensure Flutter bindings are initialized
// //     WidgetsFlutterBinding.ensureInitialized();
// //
// //     // Initialize SharedPrefs
// //     try {
// //       await SharedPrefs.init();
// //     } catch (e) {
// //       log('SharedPrefs initialization failed: $e');
// //     }
// //
// //     // Environment setup
// //     environmentsChanging();
// //
// //     // Listen for app lifecycle changes
// //     WidgetsBinding.instance.addObserver(MainConfig());
// //
// //     // Initialize Firebase safely
// //     try {
// //       await Firebase.initializeApp(
// //         name: 'AtomEdge',
// //         options: DefaultFirebaseOptions.currentPlatform,
// //       );
// //       log('Firebase initialized successfully');
// //
// //       // Enable Crashlytics
// //       FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
// //
// //       // Catch all Flutter errors
// //       FlutterError.onError = (FlutterErrorDetails details) {
// //         FirebaseCrashlytics.instance.recordFlutterFatalError(details);
// //       };
// //
// //       // Catch all async errors
// //       PlatformDispatcher.instance.onError = (error, stack) {
// //         FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
// //         return true;
// //       };
// //
// //       FirebaseCrashlytics.instance.log('App started');
// //     } catch (e) {
// //       log('Firebase initialization failed: $e');
// //       // Optionally report the error to your own logging system
// //     }
// //
// //     // Initialize routing
// //     String initialRouteName = await initRouting();
// //
// //     // Run the app
// //     // runApp(
// //     //   // InitializeProviders(
// //     //     ChangeNotifierProvider(
// //     //       create: (_) => ThemeProvider(),
// //     //     child: MaterialApp(
// //     //       theme: ThemeData(
// //     //         disabledColor: AppColors.textGreyThemeColor,
// //     //         fontFamily: Constants.customFontFamily,
// //     //         primarySwatch: AppColors.colorCustom,
// //     //       ),
// //     //       navigatorKey: navigatorKey,
// //     //       debugShowCheckedModeBanner: false,
// //     //       initialRoute: initialRouteName,
// //     //       onGenerateRoute: RouteGenerator.generateRoute,
// //     //       builder: (context, child) {
// //     //         return GestureDetector(
// //     //           onTap: () => InactivityFunctions().updateUserInteraction(),
// //     //           child: child!,
// //     //         );
// //     //       },
// //     //     ),
// //     //   )
// //     //  );
// //
// //     runApp(
// //       ChangeNotifierProvider(
// //         create: (_) => ThemeProvider(),
// //         child: Consumer<ThemeProvider>(
// //           builder: (context, themeProvider, child) {
// //             return MaterialApp(
// //               theme: themeProvider.themeData,
// //               navigatorKey: navigatorKey,
// //               debugShowCheckedModeBanner: false,
// //               initialRoute: initialRouteName,
// //               onGenerateRoute: RouteGenerator.generateRoute,
// //               builder: (context, child) {
// //                 return GestureDetector(
// //                   onTap: () => InactivityFunctions().updateUserInteraction(),
// //                   child: child!,
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //
// //
// //     // Start inactivity timer and device info
// //     InactivityFunctions().startInactivityTimer(navigatorKey);
// //     DeviceInformation().initPlatformState();
// //   }
// //
// //
// //   static Future<String> initRouting() async {
// //     log('--initRouting---');
// //     // Get the NavigatorState object
// //
// //     // Get the user name and token from SharedPrefs
// //     String userName = await SharedPrefs.getUserId();
// //     String token = await SharedPrefs.getToken();
// //     log('--initRouting-userName-$userName-');
// //
// //     // Check if the user is logged in
// //     if (!userName.isEmptyOrNull && !token.isEmptyOrNull) {
// //       // Check if a password change is required
// //       bool requirePasswordChange =
// //           await SharedPrefs.getIsRequiredPasswordChange();
// //
// //       // Navigate to the reset password screen if a password change is required
// //       if (requirePasswordChange) {
// //         log('--initRouting--resetPwdScreenRoute-');
// //         return resetPwdScreenRoute;
// //         // navigatorState.pushNamed(resetPwdScreenRoute);
// //         // return;
// //       }
// //
// //       // Navigate to the dashboard screen and remove all previous screens from the back stack
// //
// //       log('--initRouting--dashboardViewRoute-');
// //       return dashboardViewRoute;
// //     } else {
// //       log('--initRouting--loginScreenRoute-');
// //       // Navigate to the login screen and remove all previous screens from the back stack
// //       return loginScreenRoute;
// //     }
// //   }
// //
// //   @override
// //   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
// //     super.didChangeAppLifecycleState(state);
// //
// //     log('--state------${state.toString()}--');
// //
// //     switch (state) {
// //       case AppLifecycleState.paused:
// //         InactivityFunctions().updateUserInteraction();
// //         break;
// //       case AppLifecycleState.detached:
// //         log('--calling logout------${state.toString()}--');
// //         logout(navigatorKey);
// //         break;
// //       case AppLifecycleState.resumed:
// //         DateTime lastUserInteractionTime =
// //             await InactivityFunctions().getLastUserInteractionTime();
// //         if (InactivityFunctions().isTimeExceeded(
// //             lastUserInteractionTime, Environment().config.inactivityDuration)) {
// //           logout(navigatorKey);
// //         }
// //         break;
// //       default:
// //     }
// //   }
// //
// //   static void logout(GlobalKey<NavigatorState> navigatorKey) {
// //     InactivityFunctions().logoutUser(navigatorKey);
// //   }
// // }
//
//
import 'dart:developer';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/utils/device_infomation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'firebase_options.dart';

class MainConfig with WidgetsBindingObserver {
  static Future<void> initialSetup(GlobalKey<NavigatorState> navigatorKey) async {
    log('-initialSetup---main_config--');

    // Ensure Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize SharedPrefs
    try {
      await SharedPrefs.init();
    } catch (e) {
      log('SharedPrefs initialization failed: $e');
    }

    // Initialize environment
    environmentsChanging();

    // Listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(MainConfig());

    // Initialize Firebase safely
    try {
      await Firebase.initializeApp(
        name: 'AtomEdge',
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log('Firebase initialized successfully');

      // Enable Crashlytics
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      // Catch all Flutter errors
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      // Catch all async errors
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      FirebaseCrashlytics.instance.log('App started');
    } catch (e) {
      log('Firebase initialization failed: $e');
    }

    // Initialize routing
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

    // Start inactivity timer and device info
    InactivityFunctions().startInactivityTimer(navigatorKey);
    DeviceInformation().initPlatformState();
  }

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

  static Future<String> initRouting() async {
    log('--initRouting---');

    String userName = await SharedPrefs.getUserId();
    String token = await SharedPrefs.getToken();
    log('--initRouting-userName-$userName-');

    if (!userName.isEmptyOrNull && !token.isEmptyOrNull) {
      bool requirePasswordChange =
      await SharedPrefs.getIsRequiredPasswordChange();

      if (requirePasswordChange) {
        log('--initRouting--resetPwdScreenRoute-');
        return resetPwdScreenRoute;
      }

      log('--initRouting--dashboardViewRoute-');
      return dashboardViewRoute;
    } else {
      log('--initRouting--loginScreenRoute-');
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

/// Separate MyApp widget to avoid context issues with Provider
class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;

  const MyApp({super.key, required this.navigatorKey, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      // theme: context.watch<ThemeProvider>().themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => InactivityFunctions().updateUserInteraction(),
          child: child!,
        );
      },
    );
  }
}




// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/utils/device_infomation.dart';
//
// export 'package:flutter/material.dart';
//
// class MainConfig with WidgetsBindingObserver {
//   static environmentsChanging() {
//     log('-environmentsChanging---main_config--');
//     String environment = String.fromEnvironment(
//       'ENVIRONMENT',
//       defaultValue: F.title == "DEV"
//           ? Environment.DEV
//           : F.title == "QA"
//           ? Environment.QA
//           : F.title == "UAT"
//           ? Environment.UAT
//           : Environment.PROD,
//     );
//
//     Environment().initConfig(environment);
//   }
//
//   static initialSetup(GlobalKey<NavigatorState> navigatorKey) async {
//     log('-initialSetup---main_config--');
//
//     // Required for async calls in `main`
//     WidgetsFlutterBinding.ensureInitialized();
//
//     // Initialize SharedPrefs instance.
//     await SharedPrefs.init();
//
//     // Environment setup
//     environmentsChanging();
//
//     // Listen for app lifecycle changes
//     WidgetsBinding.instance.addObserver(MainConfig());
//
//
//
//     await Firebase.initializeApp(
//         name: 'AtomEdge',
//         options: DefaultFirebaseOptions.currentPlatform
//     );
//
//     // Enable Crashlytics collection
//     FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
//
//     // Pass all uncaught errors from the framework to Crashlytics
//     FlutterError.onError = (errorDetails) {
//       FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
//     };
//
//     // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
//     PlatformDispatcher.instance.onError = (error, stack) {
//       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//       return true;
//     };
//     FirebaseCrashlytics.instance.log('Test: Flutter App started');
//
//     log('---Firebase.initializeApp----');
//     // try {
//     //   await FCMHandler.initializeFCM();
//     //   FCMHandler.setupForegroundMessageHandler();
//     //   FCMHandler.setupBackgroundMessageHandler();
//     // } catch (e) {
//     //   // Handle Firebase initialization error
//     //   log('Firebase initialization failed: $e');
//     // }
//
//     // Locale? locale;
//     String initialRouteName = await initRouting();
//     runApp(
//       InitializeProviders(
//         child: MaterialApp(
//           theme: ThemeData(
//             disabledColor: AppColors.textGreyThemeColor,
//             fontFamily: Constants.customFontFamily,
//             primarySwatch: AppColors.colorCustom,
//           ),
//           navigatorKey: navigatorKey,
//           debugShowCheckedModeBanner: false,
//           initialRoute: initialRouteName,
//           onGenerateRoute: RouteGenerator.generateRoute,
//           // locale: locale,
//           // supportedLocales: LocaleSupportedMethod.supportedLocale,
//           // localizationsDelegates:
//           //     LocaleSupportedMethod.getLocalizationsDelegates(),
//           // localeResolutionCallback: (locale, supportedLocales) =>
//           //     LocaleSupportedMethod.getLocale(locale, supportedLocales),
//           // Add a builder to wrap your MaterialApp with a GestureDetector
//           builder: (context, child) {
//             return GestureDetector(
//               // Trigger updateUserInteraction whenever the user interacts with the app
//               onTap: () => InactivityFunctions().updateUserInteraction(),
//               child: child!,
//             );
//           },
//         ),
//       ),
//     );
//     InactivityFunctions().startInactivityTimer(navigatorKey);
//     DeviceInformation().initPlatformState();
//   }
//
//   static Future<String> initRouting() async {
//     log('--initRouting---');
//     // Get the NavigatorState object
//
//     // Get the user name and token from SharedPrefs
//     String userName = await SharedPrefs.getUserId();
//     String token = await SharedPrefs.getToken();
//     log('--initRouting-userName-$userName-');
//
//     // Check if the user is logged in
//     if (!userName.isEmptyOrNull && !token.isEmptyOrNull) {
//       // Check if a password change is required
//       bool requirePasswordChange =
//       await SharedPrefs.getIsRequiredPasswordChange();
//
//       // Navigate to the reset password screen if a password change is required
//       if (requirePasswordChange) {
//         log('--initRouting--resetPwdScreenRoute-');
//         return resetPwdScreenRoute;
//         // navigatorState.pushNamed(resetPwdScreenRoute);
//         // return;
//       }
//
//       // Navigate to the dashboard screen and remove all previous screens from the back stack
//
//       log('--initRouting--dashboardViewRoute-');
//       return dashboardViewRoute;
//     } else {
//       log('--initRouting--loginScreenRoute-');
//       // Navigate to the login screen and remove all previous screens from the back stack
//       return loginScreenRoute;
//     }
//   }
//
//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//
//     log('--state------${state.toString()}--');
//
//     switch (state) {
//       case AppLifecycleState.paused:
//         InactivityFunctions().updateUserInteraction();
//         break;
//       case AppLifecycleState.detached:
//         log('--calling logout------${state.toString()}--');
//         logout(navigatorKey);
//         break;
//       case AppLifecycleState.resumed:
//         DateTime lastUserInteractionTime =
//         await InactivityFunctions().getLastUserInteractionTime();
//         if (InactivityFunctions().isTimeExceeded(
//             lastUserInteractionTime, Environment().config.inactivityDuration)) {
//           logout(navigatorKey);
//         }
//         break;
//       default:
//     }
//   }
//
//   static void logout(GlobalKey<NavigatorState> navigatorKey) {
//     InactivityFunctions().logoutUser(navigatorKey);
//   }
// }
