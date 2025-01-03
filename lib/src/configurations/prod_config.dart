import 'package:db_atom/src/configurations/base_config.dart';

class ProdConfig implements BaseConfig {
  // @override
  // String get apiHost =>
  //     "https://api.integration.dbatom.arlanto.com/api/atomrestservice";
  @override
  String get apiHost => "https://api.dbatom.com/api/atomrestservice";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;

  @override
  Duration get inactivityDuration => const Duration(minutes: 30);

  @override
  String get keyClockApiHost => "https://sso.dbatom.com";

  @override
  String get keyClockClientId => 'atom';

  @override
  String get keyClockClientSecret => 'clwXW7iguWjrpsfLPvTGOUpW6dyiO9jw';

  @override
  String get keyClockRealm => 'Atom';

  @override
  String get aadClientId => '1b099789-de9b-4384-9925-b299f67b6c9c';

  @override
  String get aadTenantId => 'c188bbd2-2eb1-416a-9245-2f9fffb7a00f';
}
