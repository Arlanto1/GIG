import 'package:db_atom/src/configurations/base_config.dart';

class QaConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.qa.dbatom.arlanto.com/api/atomrestservice";

  // String get apiHost => "http://172.16.3.35:8081/api/atomrestservice";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;

  @override
  Duration get inactivityDuration => const Duration(minutes: 100);

  @override
  String get keyClockApiHost => "https://qa.keycloak.arlanto.com";

  @override
  String get keyClockClientId => 'atom';

  @override
  String get keyClockClientSecret => 'JbU8TZf8juktrQgsDjBwjb2W3FehRtPl';

  @override
  String get keyClockRealm => 'Atom';

  @override
  String get aadClientId => 'de402f9d-d2b7-4660-8eaf-5bda3efed464';

  @override
  String get aadTenantId => 'c188bbd2-2eb1-416a-9245-2f9fffb7a00f';
}
