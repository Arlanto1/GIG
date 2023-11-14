import 'package:db_atom/flavors.dart';
import 'package:db_atom/src/configurations/main_config.dart';

void main() {
  F.appFlavor = Flavor.qa;
  //runApp(App());
  MainConfig.initialSetup();
}
