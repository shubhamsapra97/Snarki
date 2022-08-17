import 'package:client/core/environments/base_config.dart';

class DevConfig implements BaseConfig {
  String get apiHost => "https://wz1u3d11cf.execute-api.us-east-1.amazonaws.com";
  String get mapBoxToken => "pk.eyJ1Ijoic2h1YmhhbXNhcHJhOTciLCJhIjoiY2wybmdrdHRmMTZyeDNlcGttemRvaWN4YyJ9.7hTjPUh5aNteq9KqSto6PA";
  bool get reportErrors => false;
  bool get trackEvents => false;
  String get getRestaurantApiHost => "https://vceg4zcukh.execute-api.us-east-1.amazonaws.com";
}
