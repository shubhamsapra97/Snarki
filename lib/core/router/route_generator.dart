import 'package:flutter/material.dart';
import 'package:client/modules/home/view/home_view.dart';
import 'package:client/modules/home/view/nothingSelectedView.dart';
import 'package:client/modules/mod-auth/views/forgot_password.dart';
import 'package:client/modules/mod-auth/views/login_view.dart';
import 'package:client/modules/mod-auth/views/sign_up_view.dart';
import 'package:client/modules/profile/change_password_view.dart';
import 'package:client/modules/profile/user_profile_view.dart';
import 'package:client/modules/restaurant/map_view.dart';
import 'package:client/modules/restaurants_search/restaurants_map_view.dart';
import 'package:client/modules/settings/settings_view.dart';
import 'package:client/modules/spash/view/splash_screen.dart';
import 'package:client/modules/locationPicker/location_picker_view.dart';
import 'package:client/modules/unknown_page.dart';
import 'package:client/modules/restaurant/restaurant_list.dart';
import 'package:client/modules/restaurant_direction/restaurant_directions.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpView());
      case '/forgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      // case '/mapView':
      //   return MaterialPageRoute(builder: (_) => MapView());
      // case '/restaurantMapView':
      //   return MaterialPageRoute(builder: (_) => RestaurantsMapView(cusineTag: args));
      case '/restaurantListView':
        return MaterialPageRoute(builder: (_) => RestaurantsListView(cusineTag: args as List<String>));
      case '/userProfile':
        return MaterialPageRoute(builder: (_) => UserProfileView());
      case '/changePassword':
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsView());
      case '/locationPicker':
        return MaterialPageRoute(builder: (_) => LocationPickerView(arguments: args as Map<String, dynamic>));
      case '/restaurantDirections':
        return MaterialPageRoute(builder: (_) => RestaurantDirections(arguments: args as Map<String, dynamic>));
      case '/nothingSelected':
        return MaterialPageRoute(builder: (_) => NotingSelected());
      default:
        return MaterialPageRoute(builder: (_) => UnknownPage());
    }
  }

}