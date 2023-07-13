import 'dart:ui';
import 'dart:convert';
import 'package:client/core/core.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/modules/restaurants_search/restaurants_map_view_model.dart';
import 'package:client/injection.dart';
import 'package:latlong/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:client/core/environments/environments.dart';

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
            decoration: BoxDecoration(color: AppTheme.primaryColorDark.withOpacity(0.3)),
            child: Column(
              children: [
                ListTile(
                    title: Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[300]!,
                        child: Container(
                          height: 15.0,
                          width: 60.0,
                          color: AppTheme.primaryBackgroundColor,
                        )
                    ),
                    subtitle: Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[300]!,
                        child: Container(
                          height: 15.0,
                          width: 60.0,
                          color: AppTheme.primaryBackgroundColor,
                        )
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey[500]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              height: 15.5,
                              width: 25.0,
                              color: AppTheme.primaryBackgroundColor,
                              margin: const EdgeInsets.only(bottom: 4.0),
                            )
                        ),
                        Shimmer.fromColors(
                            baseColor: Colors.grey[500]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              height: 15.5,
                              width: 25.0,
                              color: AppTheme.primaryBackgroundColor,
                            )
                        ),
                      ],
                    )
                ),
                Shimmer.fromColors(
                    baseColor: Colors.grey[500]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/details.jpg"),
                            fit: BoxFit.fitWidth,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          )
                      ),
                      child: Image(
                        image: AssetImage("assets/sidebarLogo.png"),
                      ),
                    ),
                ),
                OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    onPressed: () async {},
                    icon: const Icon(
                        Icons.navigate_next,
                        color: Color(0xFF5d5b6a),
                        size: 25
                    ),
                    label: const Text(
                        'Restaurant Details',
                        style: TextStyle(
                            color: Color(0xFF5d5b6a),
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
              ],
            )
        )
      );
    }

    return Card(
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: AppTheme.primaryColorDark.withOpacity(0.3)),
          child: Column(
            children: [
              ListTile(
                title: Text(
                    restaurant['name'],
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                    ),
                ),
                subtitle: Text(
                    '${restaurant['address']}, ${restaurant['city']}, ${restaurant['state']}, ${restaurant['postalCode']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        restaurant["priceRating"].length > 0 ? restaurant["priceRating"] : '',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text(
                        userLocation != null ? '~ ' + restaurant['distance'].toStringAsFixed(restaurant['distance'] > 0 ? 2 : 0) + ' miles' : '',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                )
              ),
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/details.jpg"),
                        fit: BoxFit.fitWidth,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    )
                ),
                child: restaurant['images']['mainPhoto'].length > 0 ? Image(
                  image: NetworkImage('https://snarki-restaurant-images.s3.amazonaws.com${restaurant["images"]["mainPhoto"]}'),
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ) : Image(
                  image: AssetImage("assets/sidebarLogo.png"),
                ),
              ),
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
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
                  icon: const Icon(
                      Icons.navigate_next,
                      color: Color(0xFF5d5b6a),
                      size: 25
                  ),
                  label: const Text(
                      'Restaurant Details',
                      style: TextStyle(
                          color: Color(0xFF5d5b6a),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
            ],
          )
        ),
    );
  }

@override
  Widget build(BuildContext context) {
    var userLocation = null;
    var sortedRestaurants = [];
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
    final bool trackEvents = Environments().config.trackEvents;

    return ViewModelBuilder<RestaurantsSearchViewModel>.reactive(
      viewModelBuilder: () => getIt<RestaurantsSearchViewModel>(),
      onModelReady: (model) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userLocation = jsonDecode(prefs.getString('location')!);

        bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

        if (trackEvents) {
          var name = isIOS
              ? 'restaurant_list_view_ios'
              : 'restaurant_list_view';
          FirebaseAnalytics().logEvent(
            name: name,
            parameters: <String, String>{
              'deviceOS': isIOS ? 'IOS' : 'Android',
              'cuisines': widget.cusineTag.toString()
            },
          );
        }
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
          backgroundColor: AppTheme.primaryBackgroundColor,
          appBar: buildAppBar(
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
              IconButton(
                  icon: Icon(Icons.person),
                  color: Colors.white,
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
            iconThemeData: IconThemeData(color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.primaryColorLight,
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
                itemCount: 2,
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
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.primaryColorLight,
                                  fontWeight: FontWeight.w500
                              ),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
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
