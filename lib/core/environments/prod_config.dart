import 'package:client/core/environments/base_config.dart';

class ProdConfig implements BaseConfig {
  String get apiHost => "";
  String get mapBoxToken => "";
  bool get reportErrors => false;
  bool get trackEvents => true;
  String get getRestaurantApiHost => "";
}
