import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

class UserProfile {
  String? id;
  String? email;
  String? name;
  String? photoUrl;

  UserProfile({this.id, this.email, this.name, this.photoUrl});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}

class QuestionModel {
  final String cuisineTag;
  final String imagePath;

  QuestionModel(this.cuisineTag, this.imagePath);

  @override
  String toString() {
    return "Are you in a mood for\n $cuisineTag?";
  }
}

@freezed
class SearchResults with _$SearchResults {
  const factory SearchResults(
      {
        // required int totalResults, // placeId
        // required String page,
        required List<Restaurant> results
      }) = _SearchResults;

  static SearchResults empty() {
    return SearchResults(results: []);
  }

  factory SearchResults.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsFromJson(json);
}

@freezed
class Restaurant with _$Restaurant {
  const factory Restaurant({
    @JsonKey(name: '_id') required String restaurantId,
    @JsonKey(name: 'name') required String restaurantName,
    required String address,
    required String city,
    required String state,
    required String postalCode,
    required String contact,
    required String hours,
    required List<String> cuisines,
    required Geometry location

    // @JsonKey(name: 'rating') double restaurantRating,
    // @JsonKey(name: 'user_ratings_total') int userRatingsCount,
    // String icon,
    // @JsonKey(name: 'opening_hours') OpeningHours hours,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}

@freezed
class Geometry with _$Geometry {
  const factory Geometry({
    String? type,
    required List<double> coordinates
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);
}

@freezed
class Geo with _$Geo {
  const factory Geo({
    required double lat,
    required double lng
  }) = _Geo;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

@freezed
class RestaurantDetails with _$RestaurantDetails {
  const factory RestaurantDetails({
    @JsonKey(name: 'formatted_address') required String address,
    @JsonKey(name: 'formatted_phone_number') required String phoneNumber,
    required List<Reviews> reviews
  }) = _RestaurantDetails;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) => _$RestaurantDetailsFromJson(json);
}

@freezed
class Reviews with _$Reviews {
  const factory Reviews({
    @JsonKey(name: 'author_name') required String authorName,
    @JsonKey(name: 'relative_time_description') required String relativeRatingTime,
    required String text,
    required int rating,
    required int time
  }) = _Reviews;

  factory Reviews.fromJson(Map<String, dynamic> json) => _$ReviewsFromJson(json);
}
