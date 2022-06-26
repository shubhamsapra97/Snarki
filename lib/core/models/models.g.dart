// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchResults _$$_SearchResultsFromJson(Map<String, dynamic> json) =>
    _$_SearchResults(
      results: (json['results'] as List<dynamic>)
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SearchResultsToJson(_$_SearchResults instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

_$_Restaurant _$$_RestaurantFromJson(Map<String, dynamic> json) =>
    _$_Restaurant(
      restaurantId: json['_id'] as String,
      restaurantName: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      contact: json['contact'] as String,
      hours: json['hours'] as String,
      cuisines:
          (json['cuisines'] as List<dynamic>).map((e) => e as String).toList(),
      location: Geometry.fromJson(json['location'] as Map<String, dynamic>),
      website: json['website'] as String,
    );

Map<String, dynamic> _$$_RestaurantToJson(_$_Restaurant instance) =>
    <String, dynamic>{
      '_id': instance.restaurantId,
      'name': instance.restaurantName,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'contact': instance.contact,
      'hours': instance.hours,
      'cuisines': instance.cuisines,
      'location': instance.location,
      'website': instance.website,
    };

_$_Geometry _$$_GeometryFromJson(Map<String, dynamic> json) => _$_Geometry(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$_GeometryToJson(_$_Geometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

_$_Geo _$$_GeoFromJson(Map<String, dynamic> json) => _$_Geo(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$_GeoToJson(_$_Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$_RestaurantDetails _$$_RestaurantDetailsFromJson(Map<String, dynamic> json) =>
    _$_RestaurantDetails(
      address: json['formatted_address'] as String,
      phoneNumber: json['formatted_phone_number'] as String,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_RestaurantDetailsToJson(
        _$_RestaurantDetails instance) =>
    <String, dynamic>{
      'formatted_address': instance.address,
      'formatted_phone_number': instance.phoneNumber,
      'reviews': instance.reviews,
    };

_$_Reviews _$$_ReviewsFromJson(Map<String, dynamic> json) => _$_Reviews(
      authorName: json['author_name'] as String,
      relativeRatingTime: json['relative_time_description'] as String,
      text: json['text'] as String,
      rating: json['rating'] as int,
      time: json['time'] as int,
    );

Map<String, dynamic> _$$_ReviewsToJson(_$_Reviews instance) =>
    <String, dynamic>{
      'author_name': instance.authorName,
      'relative_time_description': instance.relativeRatingTime,
      'text': instance.text,
      'rating': instance.rating,
      'time': instance.time,
    };

_$_UserFeedback _$$_UserFeedbackFromJson(Map<String, dynamic> json) =>
    _$_UserFeedback(
      feedbackType: json['feedbackType'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$_UserFeedbackToJson(_$_UserFeedback instance) =>
    <String, dynamic>{
      'feedbackType': instance.feedbackType,
      'fullName': instance.fullName,
      'email': instance.email,
      'description': instance.description,
    };
