// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) {
  return _SearchResults.fromJson(json);
}

/// @nodoc
class _$SearchResultsTearOff {
  const _$SearchResultsTearOff();

  _SearchResults call({required List<Restaurant> results}) {
    return _SearchResults(
      results: results,
    );
  }

  SearchResults fromJson(Map<String, Object> json) {
    return SearchResults.fromJson(json);
  }
}

/// @nodoc
const $SearchResults = _$SearchResultsTearOff();

/// @nodoc
mixin _$SearchResults {
// required int totalResults, // placeId
// required String page,
  List<Restaurant> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchResultsCopyWith<SearchResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultsCopyWith<$Res> {
  factory $SearchResultsCopyWith(
          SearchResults value, $Res Function(SearchResults) then) =
      _$SearchResultsCopyWithImpl<$Res>;
  $Res call({List<Restaurant> results});
}

/// @nodoc
class _$SearchResultsCopyWithImpl<$Res>
    implements $SearchResultsCopyWith<$Res> {
  _$SearchResultsCopyWithImpl(this._value, this._then);

  final SearchResults _value;
  // ignore: unused_field
  final $Res Function(SearchResults) _then;

  @override
  $Res call({
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Restaurant>,
    ));
  }
}

/// @nodoc
abstract class _$SearchResultsCopyWith<$Res>
    implements $SearchResultsCopyWith<$Res> {
  factory _$SearchResultsCopyWith(
          _SearchResults value, $Res Function(_SearchResults) then) =
      __$SearchResultsCopyWithImpl<$Res>;
  @override
  $Res call({List<Restaurant> results});
}

/// @nodoc
class __$SearchResultsCopyWithImpl<$Res>
    extends _$SearchResultsCopyWithImpl<$Res>
    implements _$SearchResultsCopyWith<$Res> {
  __$SearchResultsCopyWithImpl(
      _SearchResults _value, $Res Function(_SearchResults) _then)
      : super(_value, (v) => _then(v as _SearchResults));

  @override
  _SearchResults get _value => super._value as _SearchResults;

  @override
  $Res call({
    Object? results = freezed,
  }) {
    return _then(_SearchResults(
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Restaurant>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchResults with DiagnosticableTreeMixin implements _SearchResults {
  const _$_SearchResults({required this.results});

  factory _$_SearchResults.fromJson(Map<String, dynamic> json) =>
      _$$_SearchResultsFromJson(json);

  @override // required int totalResults, // placeId
// required String page,
  final List<Restaurant> results;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchResults(results: $results)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchResults'))
      ..add(DiagnosticsProperty('results', results));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SearchResults &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(results);

  @JsonKey(ignore: true)
  @override
  _$SearchResultsCopyWith<_SearchResults> get copyWith =>
      __$SearchResultsCopyWithImpl<_SearchResults>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchResultsToJson(this);
  }
}

abstract class _SearchResults implements SearchResults {
  const factory _SearchResults({required List<Restaurant> results}) =
      _$_SearchResults;

  factory _SearchResults.fromJson(Map<String, dynamic> json) =
      _$_SearchResults.fromJson;

  @override // required int totalResults, // placeId
// required String page,
  List<Restaurant> get results => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SearchResultsCopyWith<_SearchResults> get copyWith =>
      throw _privateConstructorUsedError;
}

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return _Restaurant.fromJson(json);
}

/// @nodoc
class _$RestaurantTearOff {
  const _$RestaurantTearOff();

  _Restaurant call(
      {@JsonKey(name: '_id') required String restaurantId,
      @JsonKey(name: 'name') required String restaurantName,
      required String address,
      required String city,
      required String state,
      required String postalCode,
      required String contact,
      required String hours,
      required List<String> cuisines,
      required Geometry location,
      required String website}) {
    return _Restaurant(
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      address: address,
      city: city,
      state: state,
      postalCode: postalCode,
      contact: contact,
      hours: hours,
      cuisines: cuisines,
      location: location,
      website: website,
    );
  }

  Restaurant fromJson(Map<String, Object> json) {
    return Restaurant.fromJson(json);
  }
}

/// @nodoc
const $Restaurant = _$RestaurantTearOff();

/// @nodoc
mixin _$Restaurant {
  @JsonKey(name: '_id')
  String get restaurantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get restaurantName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get postalCode => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;
  String get hours => throw _privateConstructorUsedError;
  List<String> get cuisines => throw _privateConstructorUsedError;
  Geometry get location => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantCopyWith<Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantCopyWith<$Res> {
  factory $RestaurantCopyWith(
          Restaurant value, $Res Function(Restaurant) then) =
      _$RestaurantCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: '_id') String restaurantId,
      @JsonKey(name: 'name') String restaurantName,
      String address,
      String city,
      String state,
      String postalCode,
      String contact,
      String hours,
      List<String> cuisines,
      Geometry location,
      String website});

  $GeometryCopyWith<$Res> get location;
}

/// @nodoc
class _$RestaurantCopyWithImpl<$Res> implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._value, this._then);

  final Restaurant _value;
  // ignore: unused_field
  final $Res Function(Restaurant) _then;

  @override
  $Res call({
    Object? restaurantId = freezed,
    Object? restaurantName = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? postalCode = freezed,
    Object? contact = freezed,
    Object? hours = freezed,
    Object? cuisines = freezed,
    Object? location = freezed,
    Object? website = freezed,
  }) {
    return _then(_value.copyWith(
      restaurantId: restaurantId == freezed
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantName: restaurantName == freezed
          ? _value.restaurantName
          : restaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: postalCode == freezed
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      contact: contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      hours: hours == freezed
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as String,
      cuisines: cuisines == freezed
          ? _value.cuisines
          : cuisines // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Geometry,
      website: website == freezed
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $GeometryCopyWith<$Res> get location {
    return $GeometryCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc
abstract class _$RestaurantCopyWith<$Res> implements $RestaurantCopyWith<$Res> {
  factory _$RestaurantCopyWith(
          _Restaurant value, $Res Function(_Restaurant) then) =
      __$RestaurantCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: '_id') String restaurantId,
      @JsonKey(name: 'name') String restaurantName,
      String address,
      String city,
      String state,
      String postalCode,
      String contact,
      String hours,
      List<String> cuisines,
      Geometry location,
      String website});

  @override
  $GeometryCopyWith<$Res> get location;
}

/// @nodoc
class __$RestaurantCopyWithImpl<$Res> extends _$RestaurantCopyWithImpl<$Res>
    implements _$RestaurantCopyWith<$Res> {
  __$RestaurantCopyWithImpl(
      _Restaurant _value, $Res Function(_Restaurant) _then)
      : super(_value, (v) => _then(v as _Restaurant));

  @override
  _Restaurant get _value => super._value as _Restaurant;

  @override
  $Res call({
    Object? restaurantId = freezed,
    Object? restaurantName = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? postalCode = freezed,
    Object? contact = freezed,
    Object? hours = freezed,
    Object? cuisines = freezed,
    Object? location = freezed,
    Object? website = freezed,
  }) {
    return _then(_Restaurant(
      restaurantId: restaurantId == freezed
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantName: restaurantName == freezed
          ? _value.restaurantName
          : restaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: postalCode == freezed
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      contact: contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      hours: hours == freezed
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as String,
      cuisines: cuisines == freezed
          ? _value.cuisines
          : cuisines // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Geometry,
      website: website == freezed
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Restaurant with DiagnosticableTreeMixin implements _Restaurant {
  const _$_Restaurant(
      {@JsonKey(name: '_id') required this.restaurantId,
      @JsonKey(name: 'name') required this.restaurantName,
      required this.address,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.contact,
      required this.hours,
      required this.cuisines,
      required this.location,
      required this.website});

  factory _$_Restaurant.fromJson(Map<String, dynamic> json) =>
      _$$_RestaurantFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String restaurantId;
  @override
  @JsonKey(name: 'name')
  final String restaurantName;
  @override
  final String address;
  @override
  final String city;
  @override
  final String state;
  @override
  final String postalCode;
  @override
  final String contact;
  @override
  final String hours;
  @override
  final List<String> cuisines;
  @override
  final Geometry location;
  @override
  final String website;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Restaurant(restaurantId: $restaurantId, restaurantName: $restaurantName, address: $address, city: $city, state: $state, postalCode: $postalCode, contact: $contact, hours: $hours, cuisines: $cuisines, location: $location, website: $website)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Restaurant'))
      ..add(DiagnosticsProperty('restaurantId', restaurantId))
      ..add(DiagnosticsProperty('restaurantName', restaurantName))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('postalCode', postalCode))
      ..add(DiagnosticsProperty('contact', contact))
      ..add(DiagnosticsProperty('hours', hours))
      ..add(DiagnosticsProperty('cuisines', cuisines))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('website', website));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Restaurant &&
            (identical(other.restaurantId, restaurantId) ||
                const DeepCollectionEquality()
                    .equals(other.restaurantId, restaurantId)) &&
            (identical(other.restaurantName, restaurantName) ||
                const DeepCollectionEquality()
                    .equals(other.restaurantName, restaurantName)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.city, city) ||
                const DeepCollectionEquality().equals(other.city, city)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.postalCode, postalCode) ||
                const DeepCollectionEquality()
                    .equals(other.postalCode, postalCode)) &&
            (identical(other.contact, contact) ||
                const DeepCollectionEquality()
                    .equals(other.contact, contact)) &&
            (identical(other.hours, hours) ||
                const DeepCollectionEquality().equals(other.hours, hours)) &&
            (identical(other.cuisines, cuisines) ||
                const DeepCollectionEquality()
                    .equals(other.cuisines, cuisines)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.website, website) ||
                const DeepCollectionEquality().equals(other.website, website)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(restaurantId) ^
      const DeepCollectionEquality().hash(restaurantName) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(postalCode) ^
      const DeepCollectionEquality().hash(contact) ^
      const DeepCollectionEquality().hash(hours) ^
      const DeepCollectionEquality().hash(cuisines) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(website);

  @JsonKey(ignore: true)
  @override
  _$RestaurantCopyWith<_Restaurant> get copyWith =>
      __$RestaurantCopyWithImpl<_Restaurant>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RestaurantToJson(this);
  }
}

abstract class _Restaurant implements Restaurant {
  const factory _Restaurant(
      {@JsonKey(name: '_id') required String restaurantId,
      @JsonKey(name: 'name') required String restaurantName,
      required String address,
      required String city,
      required String state,
      required String postalCode,
      required String contact,
      required String hours,
      required List<String> cuisines,
      required Geometry location,
      required String website}) = _$_Restaurant;

  factory _Restaurant.fromJson(Map<String, dynamic> json) =
      _$_Restaurant.fromJson;

  @override
  @JsonKey(name: '_id')
  String get restaurantId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'name')
  String get restaurantName => throw _privateConstructorUsedError;
  @override
  String get address => throw _privateConstructorUsedError;
  @override
  String get city => throw _privateConstructorUsedError;
  @override
  String get state => throw _privateConstructorUsedError;
  @override
  String get postalCode => throw _privateConstructorUsedError;
  @override
  String get contact => throw _privateConstructorUsedError;
  @override
  String get hours => throw _privateConstructorUsedError;
  @override
  List<String> get cuisines => throw _privateConstructorUsedError;
  @override
  Geometry get location => throw _privateConstructorUsedError;
  @override
  String get website => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RestaurantCopyWith<_Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return _Geometry.fromJson(json);
}

/// @nodoc
class _$GeometryTearOff {
  const _$GeometryTearOff();

  _Geometry call({String? type, required List<double> coordinates}) {
    return _Geometry(
      type: type,
      coordinates: coordinates,
    );
  }

  Geometry fromJson(Map<String, Object> json) {
    return Geometry.fromJson(json);
  }
}

/// @nodoc
const $Geometry = _$GeometryTearOff();

/// @nodoc
mixin _$Geometry {
  String? get type => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeometryCopyWith<Geometry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeometryCopyWith<$Res> {
  factory $GeometryCopyWith(Geometry value, $Res Function(Geometry) then) =
      _$GeometryCopyWithImpl<$Res>;
  $Res call({String? type, List<double> coordinates});
}

/// @nodoc
class _$GeometryCopyWithImpl<$Res> implements $GeometryCopyWith<$Res> {
  _$GeometryCopyWithImpl(this._value, this._then);

  final Geometry _value;
  // ignore: unused_field
  final $Res Function(Geometry) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? coordinates = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      coordinates: coordinates == freezed
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
abstract class _$GeometryCopyWith<$Res> implements $GeometryCopyWith<$Res> {
  factory _$GeometryCopyWith(_Geometry value, $Res Function(_Geometry) then) =
      __$GeometryCopyWithImpl<$Res>;
  @override
  $Res call({String? type, List<double> coordinates});
}

/// @nodoc
class __$GeometryCopyWithImpl<$Res> extends _$GeometryCopyWithImpl<$Res>
    implements _$GeometryCopyWith<$Res> {
  __$GeometryCopyWithImpl(_Geometry _value, $Res Function(_Geometry) _then)
      : super(_value, (v) => _then(v as _Geometry));

  @override
  _Geometry get _value => super._value as _Geometry;

  @override
  $Res call({
    Object? type = freezed,
    Object? coordinates = freezed,
  }) {
    return _then(_Geometry(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      coordinates: coordinates == freezed
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Geometry with DiagnosticableTreeMixin implements _Geometry {
  const _$_Geometry({this.type, required this.coordinates});

  factory _$_Geometry.fromJson(Map<String, dynamic> json) =>
      _$$_GeometryFromJson(json);

  @override
  final String? type;
  @override
  final List<double> coordinates;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Geometry(type: $type, coordinates: $coordinates)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Geometry'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('coordinates', coordinates));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Geometry &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.coordinates, coordinates) ||
                const DeepCollectionEquality()
                    .equals(other.coordinates, coordinates)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(coordinates);

  @JsonKey(ignore: true)
  @override
  _$GeometryCopyWith<_Geometry> get copyWith =>
      __$GeometryCopyWithImpl<_Geometry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeometryToJson(this);
  }
}

abstract class _Geometry implements Geometry {
  const factory _Geometry({String? type, required List<double> coordinates}) =
      _$_Geometry;

  factory _Geometry.fromJson(Map<String, dynamic> json) = _$_Geometry.fromJson;

  @override
  String? get type => throw _privateConstructorUsedError;
  @override
  List<double> get coordinates => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GeometryCopyWith<_Geometry> get copyWith =>
      throw _privateConstructorUsedError;
}

Geo _$GeoFromJson(Map<String, dynamic> json) {
  return _Geo.fromJson(json);
}

/// @nodoc
class _$GeoTearOff {
  const _$GeoTearOff();

  _Geo call({required double lat, required double lng}) {
    return _Geo(
      lat: lat,
      lng: lng,
    );
  }

  Geo fromJson(Map<String, Object> json) {
    return Geo.fromJson(json);
  }
}

/// @nodoc
const $Geo = _$GeoTearOff();

/// @nodoc
mixin _$Geo {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeoCopyWith<Geo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoCopyWith<$Res> {
  factory $GeoCopyWith(Geo value, $Res Function(Geo) then) =
      _$GeoCopyWithImpl<$Res>;
  $Res call({double lat, double lng});
}

/// @nodoc
class _$GeoCopyWithImpl<$Res> implements $GeoCopyWith<$Res> {
  _$GeoCopyWithImpl(this._value, this._then);

  final Geo _value;
  // ignore: unused_field
  final $Res Function(Geo) _then;

  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_value.copyWith(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$GeoCopyWith<$Res> implements $GeoCopyWith<$Res> {
  factory _$GeoCopyWith(_Geo value, $Res Function(_Geo) then) =
      __$GeoCopyWithImpl<$Res>;
  @override
  $Res call({double lat, double lng});
}

/// @nodoc
class __$GeoCopyWithImpl<$Res> extends _$GeoCopyWithImpl<$Res>
    implements _$GeoCopyWith<$Res> {
  __$GeoCopyWithImpl(_Geo _value, $Res Function(_Geo) _then)
      : super(_value, (v) => _then(v as _Geo));

  @override
  _Geo get _value => super._value as _Geo;

  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_Geo(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Geo with DiagnosticableTreeMixin implements _Geo {
  const _$_Geo({required this.lat, required this.lng});

  factory _$_Geo.fromJson(Map<String, dynamic> json) => _$$_GeoFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Geo(lat: $lat, lng: $lng)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Geo'))
      ..add(DiagnosticsProperty('lat', lat))
      ..add(DiagnosticsProperty('lng', lng));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Geo &&
            (identical(other.lat, lat) ||
                const DeepCollectionEquality().equals(other.lat, lat)) &&
            (identical(other.lng, lng) ||
                const DeepCollectionEquality().equals(other.lng, lng)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lat) ^
      const DeepCollectionEquality().hash(lng);

  @JsonKey(ignore: true)
  @override
  _$GeoCopyWith<_Geo> get copyWith =>
      __$GeoCopyWithImpl<_Geo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeoToJson(this);
  }
}

abstract class _Geo implements Geo {
  const factory _Geo({required double lat, required double lng}) = _$_Geo;

  factory _Geo.fromJson(Map<String, dynamic> json) = _$_Geo.fromJson;

  @override
  double get lat => throw _privateConstructorUsedError;
  @override
  double get lng => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GeoCopyWith<_Geo> get copyWith => throw _privateConstructorUsedError;
}

RestaurantDetails _$RestaurantDetailsFromJson(Map<String, dynamic> json) {
  return _RestaurantDetails.fromJson(json);
}

/// @nodoc
class _$RestaurantDetailsTearOff {
  const _$RestaurantDetailsTearOff();

  _RestaurantDetails call(
      {@JsonKey(name: 'formatted_address') required String address,
      @JsonKey(name: 'formatted_phone_number') required String phoneNumber,
      required List<Reviews> reviews}) {
    return _RestaurantDetails(
      address: address,
      phoneNumber: phoneNumber,
      reviews: reviews,
    );
  }

  RestaurantDetails fromJson(Map<String, Object> json) {
    return RestaurantDetails.fromJson(json);
  }
}

/// @nodoc
const $RestaurantDetails = _$RestaurantDetailsTearOff();

/// @nodoc
mixin _$RestaurantDetails {
  @JsonKey(name: 'formatted_address')
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'formatted_phone_number')
  String get phoneNumber => throw _privateConstructorUsedError;
  List<Reviews> get reviews => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantDetailsCopyWith<RestaurantDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantDetailsCopyWith<$Res> {
  factory $RestaurantDetailsCopyWith(
          RestaurantDetails value, $Res Function(RestaurantDetails) then) =
      _$RestaurantDetailsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'formatted_address') String address,
      @JsonKey(name: 'formatted_phone_number') String phoneNumber,
      List<Reviews> reviews});
}

/// @nodoc
class _$RestaurantDetailsCopyWithImpl<$Res>
    implements $RestaurantDetailsCopyWith<$Res> {
  _$RestaurantDetailsCopyWithImpl(this._value, this._then);

  final RestaurantDetails _value;
  // ignore: unused_field
  final $Res Function(RestaurantDetails) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<Reviews>,
    ));
  }
}

/// @nodoc
abstract class _$RestaurantDetailsCopyWith<$Res>
    implements $RestaurantDetailsCopyWith<$Res> {
  factory _$RestaurantDetailsCopyWith(
          _RestaurantDetails value, $Res Function(_RestaurantDetails) then) =
      __$RestaurantDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'formatted_address') String address,
      @JsonKey(name: 'formatted_phone_number') String phoneNumber,
      List<Reviews> reviews});
}

/// @nodoc
class __$RestaurantDetailsCopyWithImpl<$Res>
    extends _$RestaurantDetailsCopyWithImpl<$Res>
    implements _$RestaurantDetailsCopyWith<$Res> {
  __$RestaurantDetailsCopyWithImpl(
      _RestaurantDetails _value, $Res Function(_RestaurantDetails) _then)
      : super(_value, (v) => _then(v as _RestaurantDetails));

  @override
  _RestaurantDetails get _value => super._value as _RestaurantDetails;

  @override
  $Res call({
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_RestaurantDetails(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<Reviews>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RestaurantDetails
    with DiagnosticableTreeMixin
    implements _RestaurantDetails {
  const _$_RestaurantDetails(
      {@JsonKey(name: 'formatted_address') required this.address,
      @JsonKey(name: 'formatted_phone_number') required this.phoneNumber,
      required this.reviews});

  factory _$_RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      _$$_RestaurantDetailsFromJson(json);

  @override
  @JsonKey(name: 'formatted_address')
  final String address;
  @override
  @JsonKey(name: 'formatted_phone_number')
  final String phoneNumber;
  @override
  final List<Reviews> reviews;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantDetails(address: $address, phoneNumber: $phoneNumber, reviews: $reviews)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantDetails'))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('reviews', reviews));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RestaurantDetails &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.reviews, reviews) ||
                const DeepCollectionEquality().equals(other.reviews, reviews)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(reviews);

  @JsonKey(ignore: true)
  @override
  _$RestaurantDetailsCopyWith<_RestaurantDetails> get copyWith =>
      __$RestaurantDetailsCopyWithImpl<_RestaurantDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RestaurantDetailsToJson(this);
  }
}

abstract class _RestaurantDetails implements RestaurantDetails {
  const factory _RestaurantDetails(
      {@JsonKey(name: 'formatted_address') required String address,
      @JsonKey(name: 'formatted_phone_number') required String phoneNumber,
      required List<Reviews> reviews}) = _$_RestaurantDetails;

  factory _RestaurantDetails.fromJson(Map<String, dynamic> json) =
      _$_RestaurantDetails.fromJson;

  @override
  @JsonKey(name: 'formatted_address')
  String get address => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'formatted_phone_number')
  String get phoneNumber => throw _privateConstructorUsedError;
  @override
  List<Reviews> get reviews => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RestaurantDetailsCopyWith<_RestaurantDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

Reviews _$ReviewsFromJson(Map<String, dynamic> json) {
  return _Reviews.fromJson(json);
}

/// @nodoc
class _$ReviewsTearOff {
  const _$ReviewsTearOff();

  _Reviews call(
      {@JsonKey(name: 'author_name')
          required String authorName,
      @JsonKey(name: 'relative_time_description')
          required String relativeRatingTime,
      required String text,
      required int rating,
      required int time}) {
    return _Reviews(
      authorName: authorName,
      relativeRatingTime: relativeRatingTime,
      text: text,
      rating: rating,
      time: time,
    );
  }

  Reviews fromJson(Map<String, Object> json) {
    return Reviews.fromJson(json);
  }
}

/// @nodoc
const $Reviews = _$ReviewsTearOff();

/// @nodoc
mixin _$Reviews {
  @JsonKey(name: 'author_name')
  String get authorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'relative_time_description')
  String get relativeRatingTime => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewsCopyWith<Reviews> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewsCopyWith<$Res> {
  factory $ReviewsCopyWith(Reviews value, $Res Function(Reviews) then) =
      _$ReviewsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'author_name') String authorName,
      @JsonKey(name: 'relative_time_description') String relativeRatingTime,
      String text,
      int rating,
      int time});
}

/// @nodoc
class _$ReviewsCopyWithImpl<$Res> implements $ReviewsCopyWith<$Res> {
  _$ReviewsCopyWithImpl(this._value, this._then);

  final Reviews _value;
  // ignore: unused_field
  final $Res Function(Reviews) _then;

  @override
  $Res call({
    Object? authorName = freezed,
    Object? relativeRatingTime = freezed,
    Object? text = freezed,
    Object? rating = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      authorName: authorName == freezed
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      relativeRatingTime: relativeRatingTime == freezed
          ? _value.relativeRatingTime
          : relativeRatingTime // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ReviewsCopyWith<$Res> implements $ReviewsCopyWith<$Res> {
  factory _$ReviewsCopyWith(_Reviews value, $Res Function(_Reviews) then) =
      __$ReviewsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'author_name') String authorName,
      @JsonKey(name: 'relative_time_description') String relativeRatingTime,
      String text,
      int rating,
      int time});
}

/// @nodoc
class __$ReviewsCopyWithImpl<$Res> extends _$ReviewsCopyWithImpl<$Res>
    implements _$ReviewsCopyWith<$Res> {
  __$ReviewsCopyWithImpl(_Reviews _value, $Res Function(_Reviews) _then)
      : super(_value, (v) => _then(v as _Reviews));

  @override
  _Reviews get _value => super._value as _Reviews;

  @override
  $Res call({
    Object? authorName = freezed,
    Object? relativeRatingTime = freezed,
    Object? text = freezed,
    Object? rating = freezed,
    Object? time = freezed,
  }) {
    return _then(_Reviews(
      authorName: authorName == freezed
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      relativeRatingTime: relativeRatingTime == freezed
          ? _value.relativeRatingTime
          : relativeRatingTime // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Reviews with DiagnosticableTreeMixin implements _Reviews {
  const _$_Reviews(
      {@JsonKey(name: 'author_name')
          required this.authorName,
      @JsonKey(name: 'relative_time_description')
          required this.relativeRatingTime,
      required this.text,
      required this.rating,
      required this.time});

  factory _$_Reviews.fromJson(Map<String, dynamic> json) =>
      _$$_ReviewsFromJson(json);

  @override
  @JsonKey(name: 'author_name')
  final String authorName;
  @override
  @JsonKey(name: 'relative_time_description')
  final String relativeRatingTime;
  @override
  final String text;
  @override
  final int rating;
  @override
  final int time;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Reviews(authorName: $authorName, relativeRatingTime: $relativeRatingTime, text: $text, rating: $rating, time: $time)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Reviews'))
      ..add(DiagnosticsProperty('authorName', authorName))
      ..add(DiagnosticsProperty('relativeRatingTime', relativeRatingTime))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('time', time));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reviews &&
            (identical(other.authorName, authorName) ||
                const DeepCollectionEquality()
                    .equals(other.authorName, authorName)) &&
            (identical(other.relativeRatingTime, relativeRatingTime) ||
                const DeepCollectionEquality()
                    .equals(other.relativeRatingTime, relativeRatingTime)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(authorName) ^
      const DeepCollectionEquality().hash(relativeRatingTime) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(time);

  @JsonKey(ignore: true)
  @override
  _$ReviewsCopyWith<_Reviews> get copyWith =>
      __$ReviewsCopyWithImpl<_Reviews>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReviewsToJson(this);
  }
}

abstract class _Reviews implements Reviews {
  const factory _Reviews(
      {@JsonKey(name: 'author_name')
          required String authorName,
      @JsonKey(name: 'relative_time_description')
          required String relativeRatingTime,
      required String text,
      required int rating,
      required int time}) = _$_Reviews;

  factory _Reviews.fromJson(Map<String, dynamic> json) = _$_Reviews.fromJson;

  @override
  @JsonKey(name: 'author_name')
  String get authorName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'relative_time_description')
  String get relativeRatingTime => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  int get rating => throw _privateConstructorUsedError;
  @override
  int get time => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ReviewsCopyWith<_Reviews> get copyWith =>
      throw _privateConstructorUsedError;
}

UserFeedback _$UserFeedbackFromJson(Map<String, dynamic> json) {
  return _UserFeedback.fromJson(json);
}

/// @nodoc
class _$UserFeedbackTearOff {
  const _$UserFeedbackTearOff();

  _UserFeedback call(
      {required String feedbackType,
      required String fullName,
      required String email,
      required String description}) {
    return _UserFeedback(
      feedbackType: feedbackType,
      fullName: fullName,
      email: email,
      description: description,
    );
  }

  UserFeedback fromJson(Map<String, Object> json) {
    return UserFeedback.fromJson(json);
  }
}

/// @nodoc
const $UserFeedback = _$UserFeedbackTearOff();

/// @nodoc
mixin _$UserFeedback {
  String get feedbackType => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserFeedbackCopyWith<UserFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFeedbackCopyWith<$Res> {
  factory $UserFeedbackCopyWith(
          UserFeedback value, $Res Function(UserFeedback) then) =
      _$UserFeedbackCopyWithImpl<$Res>;
  $Res call(
      {String feedbackType, String fullName, String email, String description});
}

/// @nodoc
class _$UserFeedbackCopyWithImpl<$Res> implements $UserFeedbackCopyWith<$Res> {
  _$UserFeedbackCopyWithImpl(this._value, this._then);

  final UserFeedback _value;
  // ignore: unused_field
  final $Res Function(UserFeedback) _then;

  @override
  $Res call({
    Object? feedbackType = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      feedbackType: feedbackType == freezed
          ? _value.feedbackType
          : feedbackType // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserFeedbackCopyWith<$Res>
    implements $UserFeedbackCopyWith<$Res> {
  factory _$UserFeedbackCopyWith(
          _UserFeedback value, $Res Function(_UserFeedback) then) =
      __$UserFeedbackCopyWithImpl<$Res>;
  @override
  $Res call(
      {String feedbackType, String fullName, String email, String description});
}

/// @nodoc
class __$UserFeedbackCopyWithImpl<$Res> extends _$UserFeedbackCopyWithImpl<$Res>
    implements _$UserFeedbackCopyWith<$Res> {
  __$UserFeedbackCopyWithImpl(
      _UserFeedback _value, $Res Function(_UserFeedback) _then)
      : super(_value, (v) => _then(v as _UserFeedback));

  @override
  _UserFeedback get _value => super._value as _UserFeedback;

  @override
  $Res call({
    Object? feedbackType = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? description = freezed,
  }) {
    return _then(_UserFeedback(
      feedbackType: feedbackType == freezed
          ? _value.feedbackType
          : feedbackType // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserFeedback with DiagnosticableTreeMixin implements _UserFeedback {
  const _$_UserFeedback(
      {required this.feedbackType,
      required this.fullName,
      required this.email,
      required this.description});

  factory _$_UserFeedback.fromJson(Map<String, dynamic> json) =>
      _$$_UserFeedbackFromJson(json);

  @override
  final String feedbackType;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserFeedback(feedbackType: $feedbackType, fullName: $fullName, email: $email, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserFeedback'))
      ..add(DiagnosticsProperty('feedbackType', feedbackType))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserFeedback &&
            (identical(other.feedbackType, feedbackType) ||
                const DeepCollectionEquality()
                    .equals(other.feedbackType, feedbackType)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(feedbackType) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(description);

  @JsonKey(ignore: true)
  @override
  _$UserFeedbackCopyWith<_UserFeedback> get copyWith =>
      __$UserFeedbackCopyWithImpl<_UserFeedback>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserFeedbackToJson(this);
  }
}

abstract class _UserFeedback implements UserFeedback {
  const factory _UserFeedback(
      {required String feedbackType,
      required String fullName,
      required String email,
      required String description}) = _$_UserFeedback;

  factory _UserFeedback.fromJson(Map<String, dynamic> json) =
      _$_UserFeedback.fromJson;

  @override
  String get feedbackType => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserFeedbackCopyWith<_UserFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}
