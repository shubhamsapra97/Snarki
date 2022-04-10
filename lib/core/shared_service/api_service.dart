import 'dart:convert';

import 'package:client/injection.dart';
import 'package:client/core/http_services/api_result.dart';
import 'package:client/core/http_services/dio_client.dart';
import 'package:client/core/http_services/network_exceptions.dart';
import 'package:client/core/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ApiRepository {
  DioClient? dioClient = null;
  String _baseUrl = "https://wz1u3d11cf.execute-api.us-east-1.amazonaws.com";
  LocationData? _networkLocationData;
  Map<String, dynamic>? _locationData;
  Map<String, dynamic>? get locationData => _locationData;
  LocationData? get networkLocationData => _networkLocationData;

  ApiRepository() {
    var dio = Dio();
    dioClient = DioClient(_baseUrl, dio);
  }

  Future<ApiResult<SearchResults>> fetchAllRestaurants(cuisines) async {
    double latitude, longitude;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('location') ?? null;

    if (location == null) {
      await getIt<DialogService>().showDialog(
          title: "Error",
          description: NetworkExceptions.getErrorMessage(NetworkExceptions.locationError()));
      return ApiResult.failure(error: NetworkExceptions.locationError());
    } else {
      _locationData = jsonDecode(location);
      latitude = _locationData!['lat'];
      longitude = _locationData!['lng'];
    }

    if (dioClient != null) {
      try {
        final response = await dioClient!.get("/",
            queryParameters: {
              "cuisine": jsonEncode(cuisines),
              "latitude": latitude,
              "longitude": longitude,
              "distance":
              "${Settings.getValue<double>("radius", 5).round().toString()}",
            });
        SearchResults searchResults = SearchResults.fromJson(
            {"results": jsonDecode(response)});
        return ApiResult.success(data: searchResults);
      } catch (e) {
        return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
    } else {
      print('Failed to send request! dioClient is null');
    }

    return ApiResult.failure(error: NetworkExceptions.getDioException('DioClient cannot be null'));
  }
}
