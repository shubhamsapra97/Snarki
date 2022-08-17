import 'dart:core';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:client/core/shared_service/api_service.dart';
import 'package:client/core/http_services/network_exceptions.dart';
import 'package:client/core/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class FirebaseDynamicLinkService{

  static Future<String> createDynamicLink(bool  short, Map<String, dynamic> restaurant) async {
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://snarkiapp.page.link',
      link: Uri.parse('https://snarkiapp.com?restaurant_id=${restaurant['_id']}'),
      androidParameters: AndroidParameters(
        packageName: 'com.snarkiApp.snarkiApp',
        minimumVersion: 1,
        fallbackUrl: Uri.parse('https://www.snarkiapp.com/')
      ),
      iosParameters: IosParameters(
        bundleId: 'com.snarkiApp.snarkiApp',
        minimumVersion: '1',
        appStoreId: '1590356613',
        fallbackUrl: Uri.parse('https://www.snarkiapp.com/')
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    _linkMessage = url.toString();
    return _linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    final ApiRepository _apiRepository = ApiRepository();

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (dynamicLink) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var userLocation = jsonDecode(prefs.getString('location')!);

          if (dynamicLink != null) {
            final Uri deepLink = dynamicLink.link;
            var restaurantId = deepLink.queryParameters['restaurant_id'];
            if (restaurantId != null) {
                try {
                  var response = await _apiRepository.fetchRestaurantsById(restaurantId);
                  response.when(success: (restaurants) async {

                    Restaurant restaurantData = restaurants.results[0];
                    return Navigator.of(context).pushNamed(
                        '/restaurantDirections',
                        arguments: {
                          'restaurant': {...restaurantData.toJson()},
                          'userLatitude': userLocation['lat'],
                          'userLongitude': userLocation['lng'],
                          'restaurantLatitude': restaurantData.location.coordinates[1],
                          'restaurantLongitude': restaurantData.location.coordinates[0]
                        }
                    );
                  }, failure: (NetworkExceptions error) async {
                    print("Error while fetching restaurants list: $error");
                  });
                } catch(error) {
                  print("Error executing fetching restaurants list block: $error");
                }

              return null;
            }
          }
        }, onError: (OnLinkErrorException e) async{
          print('link error');
        }
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userLocation = jsonDecode(prefs.getString('location')!);
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      try {
        final Uri deepLink = data.link;
        var restaurantId = deepLink.queryParameters['restaurant_id'];
        if (restaurantId != null) {
          try{
            var response = await _apiRepository.fetchRestaurantsById(restaurantId);
            response.when(success: (restaurants) {
              Restaurant restaurantData = restaurants.results[0];

              return Navigator.of(context).pushNamed(
                  '/restaurantDirections',
                  arguments: {
                    'restaurant': {...restaurantData.toJson()},
                    'userLatitude': userLocation['lat'],
                    'userLongitude': userLocation['lng'],
                    'restaurantLatitude': restaurantData.location.coordinates[1],
                    'restaurantLongitude': restaurantData.location.coordinates[0]
                  }
              );
            }, failure: (NetworkExceptions error) async {
              print("Error while fetching restaurants list: $error");
            });
          }catch(e){
            print(e);
          }
        }
      } catch (e) {
        print('No deepLink found');
      }
    }
  }
}