import 'package:client/core/shared_service/auth_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

@injectable
class SplashViewModel extends BaseViewModel {
  final AuthService _authService;

  SplashViewModel(this._authService);

  Future handleStartUpLogic(BuildContext context) async {
    Future.delayed(Duration(seconds: 2), () => {
      Navigator.of(context).pushNamed(
          '/locationPicker',
        arguments: {
            'fetchLocation': true
        }
      )
    });
  }
}
