import 'package:client/core/core.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef Marker MarkerUpdateAction(Marker marker);

class RestaurantMarkerBody extends StatelessWidget {
  final Restaurant restaurant;
  final BitmapDescriptor image;
  final Function(Restaurant) onTap;
  GoogleMapController? controller;
  List<Marker> _markers = [];

  RestaurantMarkerBody({required this.onTap, required this.restaurant, required this.image});

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    _addMarker();
    return Container(
      margin: EdgeInsets.only(bottom: 170),
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        mapToolbarEnabled: true,
        indoorViewEnabled: true,
        tiltGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(restaurant.location.coordinates[1], restaurant.location.coordinates[0]),
          zoom: 17.0,
        ),
        markers: Set<Marker>.of(_markers),
      ),
    );
  }

  void _addMarker() async {
    final Marker marker = Marker(
      markerId: MarkerId(restaurant.restaurantId.toString()),
      position: LatLng(restaurant.location.coordinates[1], restaurant.location.coordinates[0]),
      icon: image,
      consumeTapEvents: true,
      flat: true,
      visible: true,
      infoWindow: InfoWindow(
          title: restaurant.restaurantName,
          // snippet: restaurant.address.formatted,
          snippet: "Address Here!!",
          onTap: () {
            onTap(restaurant);
          }),
    );
    if (controller != null) {
      controller!.showMarkerInfoWindow(marker.markerId);
    }
    if (!_markers.contains(marker)) {
      _markers.add(marker);
    }
  }
}
