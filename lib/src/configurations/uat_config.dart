import 'package:db_atom/src/configurations/base_config.dart';

class UatConfig implements BaseConfig {
  String get apiHost => "localhost";

  bool get reportErrors => false;

  bool get trackEvents => false;

  bool get useHttps => false;
}
