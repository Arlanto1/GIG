import 'dart:async';
import 'dart:developer';

import 'package:db_atom/flavors.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/InactivityFunctions.dart';

import 'src/utils/shared_preferences.dart';

// Global key to track user activity
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  F.appFlavor = Flavor.qa;
  //runApp(App());
  MainConfig.initialSetup(navigatorKey);
  InactivityFunctions().startInactivityTimer(navigatorKey);
}