import 'package:db_atom/index.dart';

// Global key to track user activity
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  F.appFlavor = Flavor.dev;
  //runApp(App());
  MainConfig.initialSetup(navigatorKey);
  // InactivityFunctions().startInactivityTimer(navigatorKey);
}
