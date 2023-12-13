import 'package:db_atom/flavors.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/utils/InactivityFunctions.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Global key to track user activity
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  F.appFlavor = Flavor.qa;
  //runApp(App());
  MainConfig.initialSetup(navigatorKey);
  InactivityFunctions().startInactivityTimer(navigatorKey);
}
