import './mapbox_requests.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<Map> getDirectionsAPIResponse(LatLng source, LatLng destination) async {
  final response = await getRouteUsingMapbox(
      source,
      destination);

  if (response["error"] != null) return response;
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };

  return modifiedResponse;
}