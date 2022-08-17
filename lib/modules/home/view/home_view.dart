import 'package:flutter/material.dart';
import 'package:client/modules/home/view/question_card_view.dart';
import 'package:client/core/shared_service/firebase_dynamic_links.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(context) {

    FirebaseDynamicLinkService.initDynamicLink(context);
    return Scaffold(
        body: Center(
          child: QuestionCardView(),
        )
    );
  }
}
