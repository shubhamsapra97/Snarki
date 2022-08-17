import 'package:client/core/environments/base_config.dart';

class ProdConfig implements BaseConfig {
  String get apiHost => "https://wz1u3d11cf.execute-api.us-east-1.amazonaws.com";
  String get mapBoxToken => "pk.eyJ1Ijoic2h1YmhhbXNuYXJraSIsImEiOiJjbDJuaDB0OTgwMGFiM2dtcGhnc3lwMGU1In0.ReTVNO6W17QveKU_CiozrQ";
  bool get reportErrors => false;
  bool get trackEvents => true;
  String get getRestaurantApiHost => "https://vceg4zcukh.execute-api.us-east-1.amazonaws.com";
}
