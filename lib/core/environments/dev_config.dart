import 'package:client/core/environments/base_config.dart';

class DevConfig implements BaseConfig {
  String get apiHost => "";
  String get mapBoxToken => "";
  bool get reportErrors => false;
  bool get trackEvents => false;
  String get getRestaurantApiHost => "";
}
