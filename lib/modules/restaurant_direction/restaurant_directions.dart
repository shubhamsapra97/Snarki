import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:client/core/shared_widgets/app_bar.dart';
import 'package:client/modules/restaurant_direction/directions_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:client/core/core.dart';
import 'package:client/core/shared_utils/marker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client/core/shared_service/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class RestaurantDirections extends StatefulWidget {
  final Map<String, dynamic> arguments;
  RestaurantDirections({Key? key, this.arguments = const {}}) : super(key: key);
  @override
  _RestaurantDirections createState() => _RestaurantDirections();
}

PreferredSizeWidget _appBar(final widgetArgs, BuildContext context, double animationValue) {
  bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  var listRadius = [40.0, 48.0];

  Widget rippleContainer(radius) {
    return Container(
      width: radius * animationValue,
      height: radius * animationValue,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[500]!.withOpacity(1.0 - animationValue)
      ),
    );
  }

  return buildAppBar(
    context: context,
    automaticallyImplyLeading: true,
    title: Text(
      "S N A R K I",
      style: TextStyle(
          color: AppTheme.primaryColorLight,
          fontWeight: FontWeight.w900
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            rippleContainer(listRadius[0]),
            rippleContainer(listRadius[1]),
            IconButton(
                icon: Icon(isIOS ? Icons.ios_share_sharp : Icons.share),
                color: Colors.white,
                onPressed: () async {
                  final box = context.findRenderObject() as RenderBox?;

                  var url = await FirebaseDynamicLinkService.createDynamicLink(
                      true,
                      widgetArgs['restaurant']
                  );
                  Share.share(
                      '''Hey, Checkout ${widgetArgs['restaurant']['name']} restaurant, known for ${widgetArgs['restaurant']['cuisines'].join(", ")}. $url''',
                      subject: "Snarki - Your Personal Restaurant Selector",
                      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
                  );
                }
            )
          ],
        ),
      ),
    ],
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context, true);
        }),
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

class _RestaurantDirections extends State<RestaurantDirections> with TickerProviderStateMixin {
  late CameraPosition cameraPosition;
  List<Marker> markers = [];
  late AnimationController _animationController;
  final _controller = Completer<GoogleMapController>();
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
      lowerBound: 0.5
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(context) {

    cameraPosition = CameraPosition(
      target: LatLng(widget.arguments['userLatitude'], widget.arguments['userLongitude']),
      zoom: 11,
    );

    return FutureBuilder<dynamic>(
        future: _fetchRestaurantDirections(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            if (data['error'] != null) {
              return Scaffold(
                  appBar: _appBar(widget.arguments, context, 0.0),
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

            _animationController.forward();

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
              backgroundColor: AppTheme.primaryBackgroundColor,
              appBar: _appBar(widget.arguments, context, _animationController.value),
              drawer: DrawerCustom(),
              body: SlidingUpPanel(
                  minHeight: 95,
                  parallaxEnabled: true,
                  parallaxOffset: .5,
                  panelBuilder: (ScrollController sc) =>
                      _panelBody(sc, context, widget.arguments, data),
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
                                Flexible(
                                  child: Text(
                                    widget.arguments['restaurant']['name'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic,
                                    ),
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

  Future<dynamic> _fetchRestaurantDirections() {
    return this._memoizer.runOnce(() async {
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

      return getDirectionsAPIResponse(
          LatLng(widget.arguments['userLatitude'],
              widget.arguments['userLongitude']),
          LatLng(widget.arguments['restaurantLatitude'],
              widget.arguments['restaurantLongitude'])
      );
    });
  }
}

Widget _panelBody(
  ScrollController sc,
  BuildContext context,
  dynamic arguments,
  dynamic data)
{
  return new Stack(
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
      ListView(
        controller: sc,
        padding: EdgeInsets.only(bottom: 20),
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.drive_eta,
                  size: 40,
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
                  size: 40,
                  color: Colors.green,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: "${arguments["restaurant"]["address"]}, "
                                "${arguments["restaurant"]["city"]}, "
                                "${arguments["restaurant"]["state"]}, "
                                "${arguments["restaurant"]["postalCode"]}"
                        ));
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        var snackBar = SnackBar(content: Text('copied to clipboard'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${arguments["restaurant"]["address"]}, "
                                  "${arguments["restaurant"]["city"]}, "
                                  "${arguments["restaurant"]["state"]}, "
                                  "${arguments["restaurant"]["postalCode"]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20
                              ),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(Icons.copy, size: 20),
                              ),
                            ),
                          ],
                        ),
                      )
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
                  size: 40,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: arguments["restaurant"]["contact"]));
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    var snackBar = SnackBar(content: Text('copied to clipboard'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${arguments["restaurant"]["contact"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.copy,
                        size: 20,
                      )
                    ],
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
                  size: 40,
                  color: Colors.green,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "${arguments["restaurant"]["cuisines"].join(", ")}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (arguments["restaurant"]["website"].length != 0) ...[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.launch,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new InkWell(
                        child: new Text(
                          arguments["restaurant"]["website"],
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: 20
                          ),
                        ),
                        onTap: () async {
                          var url = arguments["restaurant"]["website"];
                          if (!await launchUrl(Uri.parse(url))) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            var snackBar = SnackBar(content: Text('Unable to launch url.'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                    ),
                  ),
                ),
              ],
            )] else Offstage(),
        ],
      ),
    ],
  );
}
