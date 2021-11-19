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

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * 0.621371 * asin(sqrt(a));
  }

  Widget makeCard(Restaurant restaurant, userLocation) {
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
                  userLocation != null ? '~ ' + (distance.as(
                    LengthUnit.Kilometer,
                    LatLng(userLocation['lat'], userLocation['lng']),
                    LatLng(restaurant.location.coordinates[1], restaurant.location.coordinates[0]),
                  ) * 0.62137).toStringAsFixed(1) + ' miles' : '',
                    style: TextStyle(color: Colors.white, fontSize: 12)
                )
              ],
            )
          ),
          title: GestureDetector(
            // When the child is tapped, show a snackbar.
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              var snackBar = SnackBar(content: Text('Timing: ${restaurant.hours} \n\nAddress: ${restaurant.address}, ${restaurant.city}, ${restaurant.state}, ${restaurant.postalCode}'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);},
            child: Text(
              restaurant.restaurantName,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              // Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Flexible(
                  child: Text(
                  '${restaurant.address}, ${restaurant.city}, ${restaurant.state}, ${restaurant.postalCode}',
                  style: TextStyle(color: Colors.white, fontSize: 12)
              ))
            ],
          ),
          trailing: IconButton(
            icon: new Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var userLocation = jsonDecode(prefs.getString('location')!);
              var url = 'https://www.google.com/maps/dir/?api=1&origin=${userLocation['lat']},${userLocation['lng']}&destination=${restaurant.location.coordinates[1]},${restaurant.location.coordinates[0]}';
              try {
                await launch(url);
              } catch(error) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                var snackBar = SnackBar(content: Text('Error while opening Google Maps.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

            },
          )
        ),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    var userLocation = null;
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
              ? Center(child: CircularProgressIndicator())
              : model.restaurants.length > 0 ? Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: model.restaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return makeCard(model.restaurants[index], userLocation);
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
                          Text(
                            "Go for different cuisines or broaden the search radius in settings.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                    )
              ),
        ),
      ),
    );
  }
}
