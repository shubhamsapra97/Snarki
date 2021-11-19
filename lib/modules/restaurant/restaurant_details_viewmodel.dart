import 'package:client/core/core.dart';
import 'package:client/core/http_services/network_exceptions.dart';
import 'package:client/core/shared_service/api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// for bitdescriptor from asset bytes
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

@injectable
class RestaurantDetailsViewModel extends BaseViewModel {
  final ApiRepository _apiRepository;
  final DialogService _dialogService;

  RestaurantDetailsViewModel(this._apiRepository, this._dialogService);

  RestaurantDetails? _restaurantById;
  RestaurantDetails? get restaurant => _restaurantById;

  BitmapDescriptor? image;

  // Future fetchRestaurantById(String id) async {
  //   setBusy(true);
  //   var result = await _apiRepository.fetchById(id);
  //   setBusy(false);
  //
  //   result.when(success: (restaurant) {
  //     restaurant.reviews.sort((a, b) => b.time.compareTo(a.time));
  //     restaurant.reviews.sort((a, b) => b.time.compareTo(a.time));
  //     _restaurantById = restaurant;
  //     notifyListeners();
  //   }, failure: (NetworkExceptions error) {
  //     _dialogService.showDialog(
  //         title: "Error",
  //         description: NetworkExceptions.getErrorMessage(error));
  //   });
  // }

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
