import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:client/core/core.dart';

@injectable
class UserService {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  Future createUser(UserProfile user) async {
    try {
      if (user != null && await _userExists(user.id!) == true) return;
      await _userCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      return e;
    }
  }

  Future getUser(String uid) async {

    try {
      var userData = await _userCollection.doc(uid).get();
      return UserProfile.fromJson(userData.data() ?? {});
    } catch (e) {
      return e;
    }
  }

  Future<bool> _userExists(String uid) async {
    DocumentSnapshot snapshot = await _userCollection.doc(uid).get();
    return snapshot.exists;
  }
}
