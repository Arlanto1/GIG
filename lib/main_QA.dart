import 'package:db_atom/src/configurations/main_config.dart';

import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.qa;
  //runApp(App());
  Mainconfig.initialSetup();
}
