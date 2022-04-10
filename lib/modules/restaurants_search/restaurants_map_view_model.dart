import 'package:client/core/core.dart';
import 'package:client/core/http_services/network_exceptions.dart';
import 'package:client/core/models/models.dart';
import 'package:client/core/shared_service/api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:client/injection.dart';
import 'package:client/core/constants/constants.dart';

// for bitdescriptor from asset bytes
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

@injectable
class RestaurantsSearchViewModel extends BaseViewModel {
  final ApiRepository _apiRepository;
  final DialogService _dialogService;
  BitmapDescriptor? image = null;

  RestaurantsSearchViewModel(this._apiRepository, this._dialogService);
  LatLng currentPosition = LatLng(40.7128, -74.0060);
  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  List<String> _cuisineTags = [];
  List<NetworkExceptions> errors = [];

  List<String> updateCuisineList(List<String> cuisines) {
    List<String> updatedCuisines = [...cuisines];
    for(var cuisine in cuisines) {
       if (similarCuisines[cuisine] != null && similarCuisines[cuisine]!.length > 0) {
         for (var newCuisine in similarCuisines[cuisine]!) {
            if (!updatedCuisines.contains(newCuisine)) updatedCuisines.add(newCuisine);
         }
       }
    }
    return updatedCuisines;
  }

  Future fetchRestaurantsList(List<String> cuisineTags) async {
    setBusy(true);
    _cuisineTags = updateCuisineList(cuisineTags);
    try {
      var response = await _apiRepository.fetchAllRestaurants(_cuisineTags);
      response.when(success: (restaurants) {
        _restaurants = restaurants.results;
      }, failure: (NetworkExceptions error) async {
        print("Error while fetching restaurants list: $error");
        errors.add(error);
      });
    } catch(error) {
      print("Error executing fetching restaurants list block: $error");
    }

    setBusy(false);

    currentPosition = LatLng(_apiRepository.locationData!['lat'], _apiRepository.locationData!['lng']);

    if (_restaurants.length == 0 && errors.length != 0) {
      var errorTitle = "Snarki was interrupted while searching restaurants.";
      if (errors[0] == NetworkExceptions.locationError()) {
        var response = await _dialogService.showConfirmationDialog(
          title: errorTitle,
          description: 'Snarki was denied access to your location. Please provide location access to Snarki from Settings.',
          confirmationTitle: "Retry",
        );

        if (response.confirmed) {
          final k = getIt<DialogService>().navigatorKey.currentContext;
          Navigator.of(k).pushNamedAndRemoveUntil(
              '/', (Route<dynamic> route) => false);
        }
      } else {
        _dialogService.showDialog(
            title: errorTitle,
            description: NetworkExceptions.getErrorMessage(errors[0]));
      }
    }
  }
}
