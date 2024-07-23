import 'package:db_atom/index.dart';

// Global key to track user activity
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// sayed.nabilal@db.com
Future<void> main() async {
  F.appFlavor = Flavor.prod;
  //runApp(App());
  MainConfig.initialSetup(navigatorKey);
  // InactivityFunctions().startInactivityTimer(navigatorKey);
}