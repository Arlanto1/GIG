import 'dart:developer';

import 'package:db_atom/src/configurations/base_config.dart';
import 'package:db_atom/src/configurations/dev_config.dart';
import 'package:db_atom/src/configurations/prod_config.dart';
import 'package:db_atom/src/configurations/qa_config.dart';
import 'package:db_atom/src/configurations/uat_config.dart';

class Environment {
  factory Environment() {
    log('--------Environment------');
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String QA = 'QA';
  static const String UAT = 'UAT';
  static const String PROD = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    log('--------Environment-----_getConfig-----$environment-');
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.UAT:
        return UatConfig();
      case Environment.QA:
        return QaConfig();
      default:
        return DevConfig();
    }
  }
}
