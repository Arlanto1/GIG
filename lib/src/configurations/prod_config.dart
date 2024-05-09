import 'package:db_atom/src/configurations/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost =>
      "https://api.integration.dbatom.arlanto.com/api/atomrestservice";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;

  @override
  Duration get inactivityDuration => const Duration(minutes: 100);
}
