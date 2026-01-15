import 'package:db_atom/index.dart';

// Global key to track user activity
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // VERY important
  F.appFlavor = Flavor.qa;
  //runApp(App());
  MainConfig.initialSetup(navigatorKey);
  // InactivityFunctions().startInactivityTimer(navigatorKey);
}





//
// class LogService {
//   static final ValueNotifier<List<String>> logsNotifier = ValueNotifier([]);
//
//   static void add(String message) {
//     logsNotifier.value = List.from(logsNotifier.value)..add(message);
//   }
// }