import 'dart:ui';
import 'dart:math';
import 'dart:convert';
import 'package:client/core/core.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/modules/restaurants_search/restaurants_map_view_model.dart';
import 'package:client/injection.dart';
import 'package:latlong/latlong.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantsListView extends StatefulWidget {
  final List<String> cusineTag;
  RestaurantsListView({Key? key, this.cusineTag = const []}) : super(key: key);

  @override
  _RestaurantsListViewState createState() => _RestaurantsListViewState();
}

class _RestaurantsListViewState extends State<RestaurantsListView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<bool> _onBackPress() {
    return Future<bool>.value(false);
  }

  Widget makeCard({restaurant, userLocation, isLoading: false}) {

    if (isLoading || restaurant == null) {
      return Card(
        elevation: 6.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              leading: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  color: Colors.grey[300],
                )
              ),
              title: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.0,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.only(bottom: 10.0),
                  )
              ),
              subtitle: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.0,
                    color: Colors.grey[300],
                  ),
              ),
              trailing: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 24,
                  width: 24,
                  color: Colors.grey[300],
                ),
              ),
          ),
        ),
      );
    }

    final Distance distance = Distance();
    return Card(
      elevation: 6.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: AppTheme.secondaryColorLight),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24)
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.restaurant,color: Colors.white),
                Text(
                  userLocation != null ? '~ ' + restaurant['distance'].toStringAsFixed(1) + ' miles' : '',
                    style: TextStyle(color: Colors.white, fontSize: 12)
                )
              ],
            )
          ),
          title: Text(
              restaurant['name'],
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              // Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Flexible(
                  child: Text(
                  '${restaurant['address']}, ${restaurant['city']}, ${restaurant['state']}, ${restaurant['postalCode']}',
                  style: TextStyle(color: Colors.white, fontSize: 12)
              ))
            ],
          ),
          trailing: IconButton(
            icon: new Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
            onPressed: () async {
              Navigator.of(context).pushNamed(
                  '/restaurantDirections',
                  arguments: {
                    'restaurant': restaurant,
                    'userLatitude': userLocation['lat'],
                    'userLongitude': userLocation['lng'],
                    'restaurantLatitude': restaurant['location'].coordinates[1],
                    'restaurantLongitude': restaurant['location'].coordinates[0]
                  }
              );
            },
          )
        ),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    var userLocation = null;
    var sortedRestaurants = [];
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;

    return ViewModelBuilder<RestaurantsSearchViewModel>.reactive(
      viewModelBuilder: () => getIt<RestaurantsSearchViewModel>(),
      onModelReady: (model) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userLocation = jsonDecode(prefs.getString('location')!);

        bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
        var name = isIOS ? 'restaurant_list_view_ios' : 'restaurant_list_view';
        FirebaseAnalytics().logEvent(
          name: name,
          parameters: <String, String>{
            'deviceOS': isIOS ? 'IOS' : 'Android',
            'cuisines': widget.cusineTag.toString()
          },
        );

        await model.fetchRestaurantsList(widget.cusineTag);

        if (model.restaurants.length > 0) {
          final Distance distance = Distance();
          sortedRestaurants = model.restaurants.map((item) {
            return {
              ...item.toJson(),
              'distance': (distance.as(
                LengthUnit.Kilometer,
                LatLng(userLocation['lat'], userLocation['lng']),
                LatLng(item.location.coordinates[1], item.location.coordinates[0]),
              ) * 0.62137)
            };
          }).toList();
          sortedRestaurants.sort((a, b) => a['distance'].compareTo(b['distance']));
        };
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: _onBackPress,
        child: Scaffold(
          appBar: buildAppBar(
            context: context,
            automaticallyImplyLeading: true,
            title: Text(
              "Snarki",
              style: TextStyle(color: AppTheme.primaryColorDark),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    var snackBar = SnackBar(content: Text('The Restaurant Distance is the exact difference between the 2 location coordinates. Traffic, shortest route and other geographical properties are not considered. Click on Arrow Icon for exact details.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
              ),
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
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.primaryColorDark,
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
            child: Icon(Icons.refresh),
          ),
          drawer: DrawerCustom(),
          body: model.isBusy
              ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(
                      restaurant: null,
                      userLocation: null,
                      isLoading: model.isBusy
                  );
                },
              ) : sortedRestaurants.length > 0 ? Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sortedRestaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return makeCard(
                        restaurant: sortedRestaurants[index],
                        userLocation: userLocation
                    );
                  },
                ),
              ) : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new SvgPicture.asset(
                            "assets/table.svg",
                            height: 200,
                            width: 200, semanticsLabel: 'Acme Logo'
                          ),
                          Text(
                              "No Restaurant found!!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              userLocation != null ?
                                "Go for different cuisines or broaden the search radius in settings."
                                : "Snarki does not have your current location. Restart the app or allow access in Settings.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                    )
              ),
        ),
      ),
    );
  }
}
