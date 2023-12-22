import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';

class InactivityFunctions {
  Future<void> startInactivityTimer(
      GlobalKey<NavigatorState> navigatorKey) async {
    log('--startInactivityTimer---');

    // String token = await SharedPrefs.getToken();
    // if(token.isEmptyOrNull) {
    //   log('Logging out because token is null.');
    //   logoutUser(navigatorKey);
    // }

    Timer.periodic(Environment().config.inactivityDuration, (timer) async {
      log('--Timer.periodic--${Environment().config.inactivityDuration}-');
      // Check user activity status, e.g., based on the last interaction time
      // For simplicity, we assume user activity is based on tapping the screen

      DateTime lastInteractionTime = await getLastUserInteractionTime();

      if (isTimeExceeded(
          lastInteractionTime, Environment().config.inactivityDuration)) {
        log('---logout now---');
        logoutUser(navigatorKey);
      }
    });
  }

  bool isTimeExceeded(
      DateTime lastInteractionTime, Duration inactivityDuration) {
    log('---isTimeExceeded--$lastInteractionTime----$inactivityDuration--');
    return lastInteractionTime
        .isBefore(DateTime.now().subtract(inactivityDuration));
  }

  Future<void> logoutUser(GlobalKey<NavigatorState> navigatorKey) async {
    log('Logging Out...');
    SharedPrefs.setUserId('');
    SharedPrefs.setEmail('');
    SharedPrefs.setToken('');
    SharedPrefs.setUsername('');
    SharedPrefs.setSessionToken('');
    SharedPrefs.setLoggedIn(false);
    SharedPrefs.setFoundId(100);
    SharedPrefs.clearSharedPreferences();
    // Navigate to the login screen
    // log('--logoutUser-${getCurrentRouteName(navigatorKey)}--');
    // if (getCurrentRouteName(navigatorKey) != loginScreenRoute) {
    navigatorKey.currentState?.pushReplacementNamed(loginScreenRoute);
    // }

    String token = await SharedPrefs.getToken();
    log('-token----after logout-$token-');
    updateUserInteraction();
  }

  Future<DateTime> getLastUserInteractionTime() async {
    log('Get Last User Interaction Time: ${DateTime.now()}');
    return DateTime.parse(await SharedPrefs.getLastInteractionTime());
  }

  // Update lastInteractionTime whenever the user interacts with the app
  Future<void> updateUserInteraction() async {
    log('Updating Last User Interaction Time: ${DateTime.now()}');
    await SharedPrefs.setLastInteractionTime(DateTime.now().toString());
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
