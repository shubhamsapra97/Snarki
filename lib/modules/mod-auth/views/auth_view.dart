import 'package:client/core/core.dart';
import 'package:client/core/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AuthView extends StatelessWidget {
  final Widget formCard;
  // final AppBar appBar;
  final model;

  const AuthView({Key? key, required this.formCard, this.model, /* this.appBar */})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Scaffold(

        backgroundColor: HexColor("f5f5f5"),
        body: formCard,
      ),
    );
  }
}
