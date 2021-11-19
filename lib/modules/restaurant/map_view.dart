// import 'package:client/core/core.dart';
// import 'package:client/modules/restaurant/restaurant_details_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:stacked/stacked.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:client/core/shared_service/auth_service.dart';
//
// import 'package:client/injection.dart';
// import 'google_map.dart';
//
// class MapView extends StatefulWidget {
//   final Restaurant restaurant;
//
//   const MapView({Key key, this.restaurant}) : super(key: key);
//
//   @override
//   _MapViewState createState() => _MapViewState();
// }
//
// class _MapViewState extends State<MapView> {
//   final double _initFabHeight = 120.0;
//   double _fabHeight;
//   double _panelHeightOpen;
//   double _panelHeightClosed = 95.0;
//   Restaurant _restaurant;
//   bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
//
//   PanelController _panelController;
//
//   @override
//   void initState() {
//     _panelController = PanelController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _panelHeightOpen = MediaQuery.of(context).size.height * .80;
//
//     return ViewModelBuilder<RestaurantDetailsViewModel>.reactive(
//         viewModelBuilder: () => getIt<RestaurantDetailsViewModel>(),
//         onModelReady: (model) async {
//           bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
//           await model.loadMarker(isIOS);
//           await model.fetchRestaurantById(widget.restaurant.restaurantId);
//         },
//         builder: (context, model, child) => Scaffold(
//               appBar: buildAppBar(
//                 context: context,
//                 title: Text(
//                   "Snarki",
//                   style: TextStyle(color: AppTheme.primaryColorDark),
//                 ),
//                 automaticallyImplyLeading: true,
//                 actions: [
//                     Theme.of(context).platform != TargetPlatform.iOS ?
//                     IconButton(
//                         icon: Icon(Icons.person),
//                         onPressed: () {
//                           if (isLoggedIn) {
//                             Navigator.of(context).pushNamed('/userProfile');
//                           } else {
//                             Navigator.of(context).pushNamed('/login');
//                           }
//                         }
//                     )
//                         :
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context, false);
//                       },
//                       child: Text("Back"),
//                     ),
//                 ],
//                 centerTitle: true,
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 bottom: PreferredSize(
//                   child: Container(
//                     color: Colors.black.withOpacity(0.5),
//                     width: double.infinity,
//                     height: 0.5,
//                   ),
//                   preferredSize: Size.fromHeight(1),
//                 ),
//               ),
//               drawer: DrawerCustom(),
//               body: model.isBusy
//                   ? Center(child: CircularProgressIndicator())
//                   : SlidingUpPanel(
//                       controller: _panelController,
//                       maxHeight: _panelHeightOpen,
//                       minHeight: _panelHeightClosed,
//                       parallaxEnabled: true,
//                       parallaxOffset: .5,
//                       body: _body(model),
//                       panelBuilder: (sc) => _panel(context, sc, model),
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(18.0),
//                           topRight: Radius.circular(18.0)),
//                       onPanelSlide: (v) {}),
//             ));
//   }
//
//   Widget _panel(
//       context, ScrollController sc, RestaurantDetailsViewModel model) {
//     bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
//     var reviewTextLength = 230;
//     var authorNameLength = 14;
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                     Colors.white.withOpacity(0.8), BlendMode.lighten),
//                 image: AssetImage(
//                   "assets/details.jpg",
//                 ))),
//         child: MediaQuery.removePadding(
//             context: context,
//             removeTop: true,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: ListView(
//                 controller: sc,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 12.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         width: 30,
//                         height: 5,
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(12.0))),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 18.0),
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "${widget.restaurant?.restaurantName}",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 24.0),
//                       ),
//                       SizedBox(height: 8.0),
//                       Text(
//                         // "${widget.restaurant?.address?.formatted}",
//                         "${model.restaurant?.address ?? ""}",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 16),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 36.0,
//                   ),
//                   // Wrap(
//                   //   alignment: WrapAlignment.center,
//                   //   spacing: 16,
//                   //   children: <Widget>[
//                   //     ...widget.restaurant?.cuisines?.map<Widget>(
//                   //       (e) => _button(
//                   //           e.toUpperCase(), Icons.restaurant, Colors.red),
//                   //     ),
//                   //     // _button("Events", Icons.event, Colors.amber),
//                   //     // _button("More", Icons.more_horiz, Colors.green),
//                   //   ],
//                   // ),
//                   // Column(
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: <Widget>[
//                   //     ...model.restaurant?.menuTags?.map<Widget>(
//                   //         (item) => Column(
//                   //           crossAxisAlignment: CrossAxisAlignment.start,
//                   //             children: <Widget>[
//                   //               ListTile(
//                   //                 contentPadding: EdgeInsets.zero,
//                   //                 title: Text(
//                   //                   '${item.menuName} Menu',
//                   //                   style: TextStyle(
//                   //                       fontWeight: FontWeight.bold, fontSize: 16.0),
//                   //                 ),
//                   //               ),
//                   //               GridView.count(
//                   //                 primary: false,
//                   //                 shrinkWrap: true,
//                   //                 crossAxisCount: 3,
//                   //                 children: [
//                   //                   ...item.menuSections?.map<Widget>(
//                   //                         (section) => RoundedCard(
//                   //                       cardColor: Colors.black.withOpacity(0.04),
//                   //                       content: Center(
//                   //                           child: Text(
//                   //                             '${section.sectionName}',
//                   //                             textAlign: TextAlign.center,
//                   //                           )),
//                   //                     ),
//                   //                   )
//                   //                 ],
//                   //               )
//                   //             ],
//                   //         ),
//                   //     ),
//                   //   ],
//                   // ),
//                   model.restaurant?.phoneNumber != null ?
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Details",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16.0),
//                     ),
//                   ) : Offstage(),
//                   model.restaurant?.phoneNumber != null ?
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: Icon(Icons.call),
//                       onTap: () async {
//                         String url = 'tel:${model.restaurant.phoneNumber}'.toString();
//                         if (await canLaunch(url)) {
//                           await launch(url);
//                         } else {
//                           throw 'Could not launch $url';
//                         }
//                       },
//                       title: Text(
//                         model.restaurant?.phoneNumber ?? "",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal, fontSize: 16.0),
//                       ),
//                     ) : Offstage(),
//                   // widget.restaurant?.hours == ""
//                   //     ? Offstage()
//                   //     : ListTile(
//                   //         contentPadding: EdgeInsets.zero,
//                   //         leading: Icon(Icons.calendar_today),
//                   //         title: Text(
//                   //           widget.restaurant.hours
//                   //               .replaceAll(":", "\t")
//                   //               .toUpperCase(),
//                   //           style: TextStyle(
//                   //               fontWeight: FontWeight.normal, fontSize: 16.0),
//                   //         ),
//                   //       ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   model.restaurant?.reviews != null ?
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Reviews",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16.0),
//                     ),
//                   ) : Text(
//                     "No Reviews available!",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16.0),
//                   ),
//
//                   model.restaurant != null &&
//                       model.restaurant.reviews.length != 0 ?
//                       GridView.count(
//                         primary: false,
//                         shrinkWrap: true,
//                         crossAxisCount: 1,
//                         childAspectRatio: 2,
//                         children: [
//                           ...model.restaurant?.reviews?.map<Widget>(
//                               (item) => new Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   new Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         item.authorName.length > authorNameLength ?
//                                         '${item.authorName.substring(0, authorNameLength)}...'
//                                         : '${item.authorName}',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold, fontSize: 16.0),
//                                       ),
//                                       // item.rating >= 0 ?
//                                       // RatingBar.builder(
//                                       //   initialRating: item.rating.toDouble(),
//                                       //   direction: Axis.horizontal,
//                                       //   allowHalfRating: true,
//                                       //   itemCount: 5,
//                                       //   itemSize: 25,
//                                       //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                                       //   itemBuilder: (context, _) => Icon(
//                                       //     Icons.star,
//                                       //     color: Colors.amber,
//                                       //   ),
//                                       // ) : Offstage(),
//                                     ],
//                                   ),
//                                   item.time != null?
//                                   Text(
//                                     '${item.relativeRatingTime}',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.normal, fontSize: 16.0),
//                                   ) : Offstage(),
//                                   item.text != null ?
//                                   SizedBox(
//                                     height: 10,
//                                   ) : Offstage(),
//                                   item.text != null ?
//                                   Flexible(child: new Text(
//                                       item.text.replaceAll("\n", "").length > reviewTextLength ?
//                                       '${item.text.replaceAll("\n", "").substring(0, reviewTextLength) + ' ...'}'
//                                       : '${item.text.replaceAll("\n", "")}',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                           fontSize: 13.0
//                                       ),
//                                     ),
//                                   ) : Offstage(),
//                                 ],
//                               ),
//                           )
//                         ]
//                       ) : Offstage(),
//
//
//
//                     // Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   children: <Widget>[
//                     //     ...model.restaurant?.reviews?.map<Widget>(
//                     //         (item) => Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //             children: <Widget>[
//                     //               GridView.count(
//                     //                 primary: false,
//                     //                 shrinkWrap: true,
//                     //                 crossAxisCount: 1,
//                     //                 childAspectRatio: 1/.4,
//                     //                 children: [
//                     //                   new Column(
//                     //                       crossAxisAlignment: CrossAxisAlignment.start,
//                     //                       children: <Widget>[
//                     //                         new Row(
//                     //                           crossAxisAlignment: CrossAxisAlignment.start,
//                     //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //                           children: <Widget>[
//                     //                             Text(
//                     //                               '${item.authorName}',
//                     //                               style: TextStyle(
//                     //                                   fontWeight: FontWeight.bold, fontSize: 16.0),
//                     //                             ),
//                     //                             item.rating >= 0 ?
//                     //                               RatingBar.builder(
//                     //                                 initialRating: item.rating.toDouble(),
//                     //                                 direction: Axis.horizontal,
//                     //                                 allowHalfRating: true,
//                     //                                 itemCount: 5,
//                     //                                 itemSize: 25,
//                     //                                 itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                     //                                 itemBuilder: (context, _) => Icon(
//                     //                                   Icons.star,
//                     //                                   color: Colors.amber,
//                     //                                 ),
//                     //                               ) : Offstage(),
//                     //                           ],
//                     //                         ),
//                     //                         item.relativeRatingTime != null?
//                     //                           Text(
//                     //                             '${item.relativeRatingTime}',
//                     //                             style: TextStyle(
//                     //                                 fontWeight: FontWeight.normal, fontSize: 16.0),
//                     //                           ) : Offstage(),
//                     //                         item.text != null ?
//                     //                           SizedBox(
//                     //                             height: 10,
//                     //                           ) : Offstage(),
//                     //                         item.text != null ?
//                     //                           Flexible(child: new Text(
//                     //                               '${item.text}',
//                     //                               style: TextStyle(
//                     //                                   fontWeight: FontWeight.normal, fontSize: 16.0),
//                     //                             ),
//                     //                           ) : Offstage()
//                     //                       ],
//                     //                   ),
//                     //                 ],
//                     //               )
//                     //             ],
//                     //         ),
//                     //     ),
//                     //   ],
//                     // ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
//
//   Widget _button(String label, IconData icon, Color color) {
//     return Container(
//       width: 75,
//       child: Column(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Icon(
//               icon,
//               color: Colors.white,
//             ),
//             decoration:
//                 BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
//               BoxShadow(
//                 color: Color.fromRGBO(0, 0, 0, 0.15),
//                 blurRadius: 8.0,
//               )
//             ]),
//           ),
//           SizedBox(
//             height: 12.0,
//           ),
//           Text(
//             label.replaceAll("AMP;", ""),
//             textAlign: TextAlign.center,
//             //  overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _body(model) {
//     return RestaurantMarkerBody(
//       image: model.image,
//       restaurant: widget.restaurant,
//       onTap: (Restaurant restaurant) {
//         _panelController.open();
//       },
//     );
//   }
// }
