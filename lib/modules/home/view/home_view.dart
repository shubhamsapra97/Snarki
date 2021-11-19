import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:client/modules/home/view/question_card_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
          child: QuestionCardView(),
        )
    );
  }
}
