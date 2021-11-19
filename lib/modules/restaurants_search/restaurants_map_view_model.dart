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

  // Future fetchRestaurants(List<String> cuisineTags) async {
  //   setBusy(true);
  //   _cuisineTags = cuisineTags;
  //
  //   var fetchRestaurantsFutures = _cuisineTags.map((cuisine) {
  //     return _apiRepository.fetchAllRestaurants(cuisine);
  //   }).toList();
  //
  //   try {
  //     var response = await Future.wait(fetchRestaurantsFutures);
  //     response.forEach((responseItem) {
  //       responseItem.when(success: (restaurants) {
  //         restaurants.results.forEach((restaurant) {
  //           var restaurantOpen = restaurant.hours?.isOpen ?? false;
  //           var validRestaurant = restaurant.businessStatus == "OPERATIONAL" && restaurantOpen;
  //           if (validRestaurant) {
  //             _restaurants.add(restaurant);
  //           }
  //         });
  //       }, failure: (NetworkExceptions error) async {
  //         errors.add(error);
  //       });
  //     });
  //   } catch(error) {
  //     print("ERROR HERER!! $error");
  //   }
  //
  //   setBusy(false);
  //
  //   currentPosition = LatLng(_apiRepository.locationData['lat'], _apiRepository.locationData['lng']);
  //
  //   if (_restaurants.length == 0 && errors.length != 0) {
  //       var errorTitle = "Snarki was interrupted while searching restaurants.";
  //       if (errors[0] == NetworkExceptions.locationError()) {
  //         var response = await _dialogService.showConfirmationDialog(
  //             title: errorTitle,
  //             description: 'Snarki was denied access to your location. Please provide location access to Snarki from Settings.',
  //             confirmationTitle: "Retry",
  //         );
  //
  //         if (response.confirmed) {
  //           ExtendedNavigator.root
  //               .pushAndRemoveUntil(Routes.homeView, (route) => false);
  //         }
  //       } else {
  //         _dialogService.showDialog(
  //             title: errorTitle,
  //             description: NetworkExceptions.getErrorMessage(errors[0]));
  //       }
  //   } else {
  //     createMarkers(_restaurants);
  //     notifyListeners();
  //   }
  // }

  // add other relevant cuisines based on selected cuisines
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
    } else {
      createMarkers(_restaurants);
      notifyListeners();
    }
  }

  void createMarkers(List<Restaurant> restaurants) {
    if (_markers.length != 0) {
      if (_markers.first.markerId == MarkerId("No-restaurant-found")) {
        _markers.clear();
      }
    }

    if (restaurants.length != 0) {
      restaurants.forEach((restaurant) {
        final marker = _getMarker(restaurant);
        if (!_markers.contains(marker)) {
          _markers.add(marker);
        }
      });
    } else {
      if (image != null) {
        _markers.add(Marker(
          icon: image!,
          markerId: MarkerId("No-restaurant-found"),
          position: LatLng(_apiRepository.locationData!['lat'],
              _apiRepository.locationData!['lng']),
          infoWindow: InfoWindow(
            title: "No Restaurants Found",
          ),
        ));
      } else {
        _markers.add(Marker(
          markerId: MarkerId("No-restaurant-found"),
          position: LatLng(_apiRepository.locationData!['lat'],
              _apiRepository.locationData!['lng']),
          infoWindow: InfoWindow(
            title: "No Restaurants Found",
          ),
        ));
      }
    }
  }

  Marker _getMarker(Restaurant restaurant) {
    final Marker marker;

    if (image != null) {
      marker = Marker(
        icon: image!,
        markerId: MarkerId(restaurant.restaurantId.toString()),
        position: LatLng(restaurant.location.coordinates[1], restaurant.location.coordinates[0]),
        infoWindow: InfoWindow(
        title: restaurant.restaurantName,
        snippet: 'Hours: ${restaurant.hours}',
        onTap: () {
          // ExtendedNavigator.root.push(Routes.mapView,
          //     arguments: MapViewArguments(restaurant: restaurant));
        })
      );
    } else {
      marker = Marker(
          markerId: MarkerId(restaurant.restaurantId.toString()),
          position: LatLng(restaurant.location.coordinates[1], restaurant.location.coordinates[0]),
          infoWindow: InfoWindow(
              title: restaurant.restaurantName,
              snippet: 'Hours: ${restaurant.hours}',
              onTap: () {
                // ExtendedNavigator.root.push(Routes.mapView,
                //     arguments: MapViewArguments(restaurant: restaurant));
              })
      );
    }
    
    return marker;
  }

  Future loadMarker(bool isIos) async {
    setBusy(true);
    try {
      var width = isIos ? 100 : 128;
      image =
      await getBitmapDescriptorFromAssetBytes('assets/food_marker.png', width);
    } catch(e) {
      print("Error while fetching custom marker $e");
    }
    setBusy(false);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    var pngImage = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    if (pngImage != null) {
      return pngImage.buffer.asUint8List();
    }

    // verify this!!
    return Uint8List.fromList([]);
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }
}
