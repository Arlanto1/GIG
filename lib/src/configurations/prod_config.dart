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
  String get aadClientId => '1e94a7ec-9f9b-43b8-943f-5ba4dfe2e021';

  @override
  String get aadTenantId => 'f18ecf29-68a6-4697-92fa-0ce29009c210';
}
