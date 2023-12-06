import 'dart:async';
import 'dart:developer';

import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';

class InactivityFunctions {
  void startInactivityTimer(GlobalKey<NavigatorState> navigatorKey) {
    log('--startInactivityTimer---');
    const inactivityDuration = Duration(minutes: 5);

    Timer.periodic(inactivityDuration, (timer) async {
      log('--Timer.periodic---');
      // Check user activity status, e.g., based on the last interaction time
      // For simplicity, we assume user activity is based on tapping the screen

      DateTime lastInteractionTime =
          DateTime.parse(await SharedPrefs.getLastInteractionTime());

      if (lastInteractionTime
          .isBefore(DateTime.now().subtract(inactivityDuration))) {
        log('--logging out---');
        logoutUser(navigatorKey);
      }
    });
  }

  void logoutUser(GlobalKey<NavigatorState> navigatorKey) {
    log('--logoutUser---');
    SharedPrefs.setUserId('');
    SharedPrefs.setEmail('');
    SharedPrefs.setToken('');
    SharedPrefs.setUsername('');
    SharedPrefs.setSessionToken('');
    SharedPrefs.setLoggedIn(false);
    SharedPrefs.setFoundId(100);
    SharedPrefs.clearSharedPreferences(); // Perform logout actions here
    // Navigate to the login screen
    log('--logoutUser-${getCurrentRouteName(navigatorKey)}--');
    if (getCurrentRouteName(navigatorKey) != loginScreenRoute) {
      navigatorKey.currentState?.pushReplacementNamed(loginScreenRoute);
    }
  }

  String getCurrentRouteName(GlobalKey<NavigatorState> navigatorKey) {
    BuildContext? currentContext = navigatorKey.currentContext;

    // Check if there is a valid context
    if (currentContext == null) {
      return "Unknown Route";
    }

    Route<dynamic>? currentRoute = ModalRoute.of(currentContext);

    // If there is no current route or it doesn't have a name, return a default value
    if (currentRoute == null || currentRoute.settings.name == null) {
      return "Unknown Route";
    }
    return currentRoute.settings.name!;
  }
}
