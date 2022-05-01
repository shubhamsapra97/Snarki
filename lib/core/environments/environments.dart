import 'package:client/core/environments/base_config.dart';
import 'package:client/core/environments/dev_config.dart';
import 'package:client/core/environments/prod_config.dart';

class Environments {
  factory Environments() {
    return _singleton;
  }

  Environments._internal();

  static final Environments _singleton = Environments._internal();

  static const String DEV = 'DEV';
  static const String PROD = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environments.PROD:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
