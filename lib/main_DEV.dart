import 'package:db_atom/src/configurations/main_config.dart';

import 'flavors.dart';

export 'package:flutter/material.dart';

void main() {
  F.appFlavor = Flavor.dev;
  //runApp(App());
  MainConfig.initialSetup();
}
