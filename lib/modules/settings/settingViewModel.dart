
import 'package:stacked/stacked.dart';


class SettingsViewModel extends BaseViewModel{

  String _radius;

  String get radius => _radius;

  void changeRadius(String v){
    _radius = v;
    notifyListeners();
  }

}