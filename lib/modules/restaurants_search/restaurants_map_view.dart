// import 'package:client/core/core.dart';
// import 'package:client/modules/restaurants_search/restaurants_map_view_model.dart';
// import 'package:flutter/material.dart';
//
// // import 'dart:math';
// import 'dart:ui';
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:stacked/stacked.dart';
// import 'package:client/core/shared_service/auth_service.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
//
// import 'package:client/injection.dart';
//
// typedef Marker MarkerUpdateAction(Marker marker);
//
// class RestaurantsMapView extends StatefulWidget {
//   final List<String> cusineTag;
//   RestaurantsMapView({Key key, this.cusineTag}) : super(key: key);
//
//   @override
//   _RestaurantsMapViewState createState() => _RestaurantsMapViewState();
// }
//
// class _RestaurantsMapViewState extends State<RestaurantsMapView> {
//   GoogleMapController controller;
//
//   void _onMapCreated(GoogleMapController controller) {
//     this.controller = controller;
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   Future<bool> _onBackPress() {
//     return Future<bool>.value(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
//     return ViewModelBuilder<RestaurantsSearchViewModel>.reactive(
//       viewModelBuilder: () => getIt<RestaurantsSearchViewModel>(),
//       onModelReady: (model) async {
//         bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
//         var name = isIOS ? 'restaurant_marker_view_ios' : 'restaurant_marker_view';
//         FirebaseAnalytics().logEvent(
//           name: name,
//           parameters: <String, String>{
//             'deviceOS': isIOS ? 'IOS' : 'Android',
//             'cuisines': widget.cusineTag.toString()
//           },
//         );
//
//         await model.loadMarker(isIOS);
//         await model.fetchRestaurantsList(widget.cusineTag);
//         if(model != null && controller != null && model.markers.length > 0) {
//           controller.showMarkerInfoWindow(model.markers.first.markerId);
//         }
//       },
//       builder: (context, model, child) => WillPopScope(
//           onWillPop: _onBackPress,
//           child: Scaffold(
//             appBar: buildAppBar(
//               context: context,
//               automaticallyImplyLeading: true,
//               title: Text(
//                 "Snarki",
//                 style: TextStyle(color: AppTheme.primaryColorDark),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.person),
//                   onPressed: () {
//                     if (isLoggedIn) {
//                       Navigator.pushNamed(context, '/userProfile');
//                     } else {
//                       Navigator.pushNamed(context, '/login');
//                     }
//                   }
//                 )
//               ],
//               centerTitle: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               bottom: PreferredSize(
//                 child: Container(
//                   color: Colors.black.withOpacity(0.5),
//                   width: double.infinity,
//                   height: 0.5,
//                 ),
//                 preferredSize: Size.fromHeight(1),
//               ),
//             ),
//             floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//             floatingActionButton: FloatingActionButton(
//               backgroundColor: AppTheme.primaryColorDark,
//               onPressed: () {
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                     '/home', (Route<dynamic> route) => false);
//               },
//               child: Icon(Icons.refresh),
//             ),
//             drawer: DrawerCustom(),
//             body: model.isBusy
//                 ? Center(child: CircularProgressIndicator())
//                 : GoogleMap(
//                     tiltGesturesEnabled: true,
//                     onMapCreated: _onMapCreated,
//                     mapToolbarEnabled: true,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     zoomGesturesEnabled: true,
//                     initialCameraPosition: CameraPosition(
//                       target: model.restaurants.isEmpty
//                           ? model.currentPosition
//                           : LatLng(model.restaurants.first.location.coordinates[1],
//                               model.restaurants.first.location.coordinates[0]),
//                       zoom: 15
//                     ),
//                     markers: Set<Marker>.of(model.markers).map((e) {
//                       return e;
//                     }).toSet(),
//                   ),
//           ),
//       ),
//     );
//   }
// }
