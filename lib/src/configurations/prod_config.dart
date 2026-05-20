import 'package:db_atom/src/configurations/base_config.dart';

class ProdConfig implements BaseConfig {
  // @override
  // String get apiHost =>
  //     "https://api.integration.dbatom.arlanto.com/api/atomrestservice";
  @override
  String get apiHost => "https://api.dbatom.com/api/atomrestservice";

  @override
  String get apiHost1 => "https://api.dbatom.com/s1/api/survey";

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
  String get aadClientId => 'de402f9d-d2b7-4660-8eaf-5bda3efed464';

  @override
  String get aadTenantId => 'f18ecf29-68a6-4697-92fa-0ce29009c210';
}
