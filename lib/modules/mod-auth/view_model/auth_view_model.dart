import 'package:client/core/core.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:injectable/injectable.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:client/core/environments/environments.dart';

@injectable
class AuthViewModel extends BaseViewModel {
  final AuthService _authService;
  final DialogService _dialogService;

  String role = Role.user;
  List<String> foodCategories = [];
  final bool trackEvents = Environments().config.trackEvents;

  AuthViewModel(this._authService, this._dialogService);

  Future signUpWithEmailAndPassword({
    context,
    String? email,
    String? password,
    String? name,
  }) async {
    setBusy(true);
    var result = await _authService.signUpWithEmailPassword(
      email: email,
      password: password,
      name: name,
    );
    setBusy(false);
    if (result != null) {
      bool isIOS = Theme
          .of(context)
          .platform == TargetPlatform.iOS;
      if (trackEvents) {
        var name = isIOS ? 'user_signed_up_ios' : 'user_signed_up';
        FirebaseAnalytics().logEvent(name: name);
      }
      Navigator.of(context).pushNamed('/home');
    }
  }

  Future signInWithEmailAndPassword(context, String email, String password) async {
    setBusy(true);

    var result = await _authService.signInWithEmailPassword(email, password);
    setBusy(false);
    if (result != null) {
      if (trackEvents) {
        FirebaseAnalytics().logEvent(
            name: 'user_logged_in'
        );
      }
      Navigator.of(context).pushNamed('/home');
    }
  }

  Future signInWithGoogle() async {
  }

  Future sendPasswordResetEmail(String email) async {
    setBusy(true);
    var result = await _authService.sendPasswordResetEmail(email);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(title: "Error", description: result);
    } else {
      await _dialogService.showDialog(
          title: "Success",
          description: "Password reset email has been sent to \n$email");
    }
  }
}
