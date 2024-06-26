// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i5;

import 'core/shared_service/api_service.dart' as _i3;
import 'core/shared_service/auth_service.dart' as _i4;
import 'core/shared_service/feedback_service.dart' as _i6;
import 'core/shared_service/location.dart' as _i12;
import 'core/shared_service/shared_firebase_analytics.dart' as _i10;
import 'core/shared_service/third_party_service.dart' as _i15;
import 'core/shared_service/user_service.dart' as _i13;
import 'modules/mod-auth/view_model/auth_view_model.dart' as _i14;
import 'modules/profile/profiel_view_model.dart' as _i7;
import 'modules/restaurant/restaurant_details_viewmodel.dart' as _i8;
import 'modules/restaurants_search/restaurants_map_view_model.dart' as _i9;
import 'modules/spash/view_model/splash_view_model.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.factory<_i3.ApiRepository>(() => _i3.ApiRepository());
  gh.singleton<_i4.AuthService>(_i4.AuthService());
  gh.lazySingleton<_i5.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.factory<_i6.FeedbackService>(() => _i6.FeedbackService());
  gh.factory<_i7.ProfileViewModel>(() =>
      _i7.ProfileViewModel(get<_i4.AuthService>(), get<_i5.DialogService>()));
  gh.factory<_i8.RestaurantDetailsViewModel>(() =>
      _i8.RestaurantDetailsViewModel(
          get<_i3.ApiRepository>(), get<_i5.DialogService>()));
  gh.factory<_i9.RestaurantsSearchViewModel>(() =>
      _i9.RestaurantsSearchViewModel(
          get<_i3.ApiRepository>(), get<_i5.DialogService>()));
  gh.lazySingleton<_i10.SharedFirebaseAnalytics>(
      () => _i10.SharedFirebaseAnalytics());
  gh.lazySingleton<_i5.SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  gh.factory<_i11.SplashViewModel>(
      () => _i11.SplashViewModel(get<_i4.AuthService>()));
  gh.factory<_i12.UserLocation>(() => _i12.UserLocation());
  gh.factory<_i13.UserService>(() => _i13.UserService());
  gh.factory<_i14.AuthViewModel>(() =>
      _i14.AuthViewModel(get<_i4.AuthService>(), get<_i5.DialogService>()));
  return get;
}

class _$ThirdPartyServicesModule extends _i15.ThirdPartyServicesModule {
  @override
  _i5.DialogService get dialogService => _i5.DialogService();
  @override
  _i5.SnackbarService get snackBarService => _i5.SnackbarService();
}
