import 'package:db_atom/src/configurations/base_config.dart';

class ProdConfig implements BaseConfig {
  String get apiHost => "https://api.integration.dbatom.arlanto.com/api/atomrestservice";

  bool get reportErrors => false;

  bool get trackEvents => false;

  bool get useHttps => false;
}
