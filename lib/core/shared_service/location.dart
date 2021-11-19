import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:client/core/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class UserLocation {
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  LocationData? get locationData => _locationData;

  Future<bool> _getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled == false) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled == false) return false;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_permissionGranted == PermissionStatus.granted) {
      location.changeSettings(interval: 1000, distanceFilter: 0, accuracy: LocationAccuracy.high);
      _locationData = await Future.any([
        location.getLocation(),
        Future.delayed(Duration(seconds: 5), () => null)
      ]);
      if (_locationData == null) {
        _locationData = await location.getLocation();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<String> setLocationToPreferences(context, fetchLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (fetchLocation) {
      prefs.remove('location');
      var getLocationResponse = await _getLocation();
      if (getLocationResponse) {
        Geo userLocation = Geo.fromJson({
          'lat': _locationData!.latitude,
          'lng': _locationData!.longitude
        });

        prefs.setString('location', jsonEncode(userLocation));
        return jsonEncode(userLocation);
      } else {
        return jsonEncode({
          'error': 'Snarki is denied location access.',
          'icon': 'assets/icon/icon.png'
        });
      }
    }

    return prefs.getString('location') ?? jsonEncode({});
  }
}