abstract class BaseConfig {
  String get apiHost;

  String get keyClockApiHost;

  String get keyClockRealm;

  String get keyClockClientSecret;

  String get keyClockClientId;

  bool get useHttps;

  bool get trackEvents;

  bool get reportErrors;

  Duration get inactivityDuration;
}
