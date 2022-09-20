import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/core/shared_service/location.dart';
import 'package:client/modules/common/app_bar.dart';
import 'package:client/injection.dart';
import 'package:client/core/shared_service/firebase_dynamic_links.dart';
import 'package:client/core/core.dart';

class LocationPickerView extends StatefulWidget {
  final Map<String, dynamic> arguments;
  LocationPickerView({Key? key, this.arguments = const {}}) : super(key: key);
  @override
  _LocationPickerView createState() => _LocationPickerView();
}

class _LocationPickerView extends State<LocationPickerView> {
  CameraPosition cameraPosition = CameraPosition(target: LatLng(1, 1));
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: getIt<UserLocation>().setLocationToPreferences(context, widget.arguments['fetchLocation']),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data!);

            if (data['error'] != null) {
              return AppBarWidget(
                message: data['error'],
                icon: data['icon'],
                drawerRequired: widget.arguments['drawerRequired'] ?? true,
              );
            }

            cameraPosition = CameraPosition(
              target: LatLng(data['lat'], data['lng']),
              zoom: 16.4746,
            );

            return Scaffold(
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  MapPicker(
                    iconWidget: SvgPicture.asset(
                      "assets/marker.svg",
                      height: 60,
                    ),
                    mapPickerController: mapPickerController,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: cameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onCameraMove: (cameraPosition) {
                        this.cameraPosition = cameraPosition;
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        child: const Text(
                          "Confirm your location",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFFFFFFFF),
                            fontSize: 19,
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          Geo userLocation = Geo.fromJson({
                            'lat': cameraPosition.target.latitude,
                            'lng': cameraPosition.target.longitude
                          });
                          prefs.setString('location', jsonEncode(userLocation));

                          FirebaseDynamicLinkService.initDynamicLink(context);

                          Navigator.of(context).pushNamed('/home');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xFFA3080C)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            body:Center(
              child: CircularProgressIndicator()
            ),
          );
        }
    );
  }
}
