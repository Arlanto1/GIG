import 'package:db_atom/src/configurations/base_config.dart';

class QaConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.qa.dbatom.arlanto.com/api/atomrestservice";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;
}
