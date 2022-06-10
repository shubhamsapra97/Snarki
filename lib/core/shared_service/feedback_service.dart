import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:client/core/core.dart';



@injectable
class FeedbackService {
  final _feedbackCollection = FirebaseFirestore.instance.collection("feedback");

  Future createFeedback(UserFeedback feedback) async {
    try {
      await _feedbackCollection.add(feedback.toJson());
    } catch (e) {
      if (e is PlatformException) {
        throw ErrorDescription(e.message!);
      }
      throw ErrorDescription(e.toString());
    }
  }
}
