import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:client/core/shared_widgets/app_bar.dart';
import 'package:client/modules/restaurant_direction/directions_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:client/injection.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:client/core/core.dart';
import 'package:client/core/shared_utils/marker.dart';


class RestaurantDirections extends StatefulWidget {
  final Map<String, dynamic> arguments;
  RestaurantDirections({Key? key, this.arguments = const {}}) : super(key: key);
  @override
  _RestaurantDirections createState() => _RestaurantDirections();
}

PreferredSizeWidget _appBar(BuildContext context) {
  bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
  return buildAppBar(
    context: context,
    automaticallyImplyLeading: true,
    title: Text(
      "Snarki",
      style: TextStyle(color: AppTheme.primaryColorDark),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          if (isLoggedIn) {
            Navigator.pushNamed(context, '/userProfile');
          } else {
            Navigator.pushNamed(context, '/login');
          }
        }
      )
    ],
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    bottom: PreferredSize(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        width: double.infinity,
        height: 0.5,
      ),
      preferredSize: Size.fromHeight(1),
    ),
  );
}

class _RestaurantDirections extends State<RestaurantDirections> {
  late CameraPosition cameraPosition;
  final _controller = Completer<GoogleMapController>();

  @override
  Widget build(context) {
    List<Marker> markers = [];
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    loadMarker(isIOS, 'assets/food_marker.png').then((icon) {
      markers.add(Marker(
          markerId: MarkerId('Destination'),
          position: LatLng(widget.arguments['restaurantLatitude'], widget.arguments['restaurantLongitude']),
          infoWindow: InfoWindow(
            title: "Restaurant",
            snippet: widget.arguments["restaurant"]["name"],
          ),
          icon: icon
      ));
    });

    markers.add(Marker(
      markerId: MarkerId('Source'),
      position: LatLng(widget.arguments['userLatitude'], widget.arguments['userLongitude']),
      infoWindow: InfoWindow(
        title: "Your Location",
      ),
    ));

    cameraPosition = CameraPosition(
      target: LatLng(widget.arguments['userLatitude'], widget.arguments['userLongitude']),
      zoom: 11,
    );

    return FutureBuilder<Map<dynamic, dynamic>>(
        future: getDirectionsAPIResponse(
            LatLng(widget.arguments['userLatitude'],
                widget.arguments['userLongitude']),
            LatLng(widget.arguments['restaurantLatitude'],
                widget.arguments['restaurantLongitude'])
        ),
        builder: (context, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            if (data['error'] != null) {
              return Scaffold(
                  appBar: _appBar(context),
                  drawer: DrawerCustom(),
                  backgroundColor: Color(0xfff5f5f5),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                          data["error"],
                          style: TextStyle(
                            fontSize: 25
                          ),
                      ),
                    ),
                  ),
              );
            }

            List<Polyline> polyLineList = [];
            polyLineList.add(
              Polyline(
                polylineId: const PolylineId("overview_polyline"),
                color: Colors.green,
                width: 5,
                points: data["geometry"]["coordinates"]
                  .map<LatLng>((e) => LatLng(e[1], e[0]))
                  .toList()
              ),
            );

            BorderRadiusGeometry radius = BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            );

            return Scaffold(
              backgroundColor: Color(0xfff5f5f5),
              appBar: _appBar(context),
              drawer: DrawerCustom(),
              body: SlidingUpPanel(
                  minHeight: 95,
                  panel: new Stack(
                    children: <Widget>[
                      new Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/details.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.6), BlendMode.lighten),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              height: 20
                          ),
                          Center(
                            child: Container(
                              color: Colors.grey,
                              height: 4,
                              width: 30,
                            ),
                          ),
                          SizedBox(
                              height: 60
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.drive_eta,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${(data["distance"] * 0.00062137).toStringAsFixed(0)} miles",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 25
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.location_pin,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "${widget.arguments["restaurant"]["address"]}, "
                                        "${widget.arguments["restaurant"]["city"]}, "
                                        "${widget.arguments["restaurant"]["state"]}, "
                                        "${widget.arguments["restaurant"]["postalCode"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: 25
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.contacts,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${widget.arguments["restaurant"]["contact"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 20
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.restaurant,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${widget.arguments["restaurant"]["cuisines"].join(", ")}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  collapsed: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: radius,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              color: Colors.grey,
                              height: 4,
                              width: 30,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:<Widget>[
                                Text(
                                  widget.arguments['restaurant']['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ]
                          )
                      ]
                  ),
                  ),
                  body: GoogleMap(
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: cameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onCameraMove: (cameraPosition) {
                        this.cameraPosition = cameraPosition;
                      },
                      polylines: Set.from(polyLineList),
                      markers: Set.from(markers),
                    ),
                    borderRadius: radius,
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
