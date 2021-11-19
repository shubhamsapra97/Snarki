import 'package:client/injection.dart';
import 'package:flutter/material.dart';
import 'package:client/modules/spash/view_model/splash_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (SplashViewModel model) => model.handleStartUpLogic(context),
      viewModelBuilder: () => getIt<SplashViewModel>(),
      builder: (context, SplashViewModel model, child) => Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Image.asset(
              "assets/logo.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
