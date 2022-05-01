import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:client/core/environments/environments.dart';
import 'package:client/core/http_services/network_exceptions.dart';

final String accessToken = Environments().config.mapBoxToken;
String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String navType = 'driving';

Dio _dio = Dio();

Future getRouteUsingMapbox(LatLng source, LatLng destination) async {
  String url =
      '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = NetworkExceptions.getErrorMessage(NetworkExceptions.getDioException(e)).toString();
    return {'error': errorMessage};
  }
}