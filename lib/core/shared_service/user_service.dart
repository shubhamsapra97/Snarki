import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:client/core/core.dart';

@injectable
class UserService {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  // final StreamController<List<UserProfile>> _userController =
  //     StreamController<List<UserProfile>>.broadcast();

  // Stream<List<UserProfile>> listenToUsersRealTime() {

  //   _userCollection.snapshots().listen((usersSnapshot) {
  //     if (usersSnapshot.documents.isNotEmpty) {
  //       var users = usersSnapshot.documents
  //           .map((snapshot) => UserProfile.fromJson(snapshot.data))
          
  //           .toList();

  //       _userController.add(users);
  //     }
  //   });

  //   return _userController.stream;
  // }

  // Future getUsersOnceOff() async {
  //   try {
  //     var doc = await _userCollection
  //         .get();
     
  //     if (doc.docChanges.isNotEmpty) {
  //       return doc.docChanges
  //           .map((snapshot) => UserProfile.fromJson(snapshot.doc.data())
         
  //           .toList();
  //     }
  //     else{
  //       return List<UserProfile>(); // return emply list
  //     }
      
  //   } catch (e) {
  //     if (e is PlatformException) {
  //       return e.message;
  //     }
  //     return e.toString();
  //   }
  // }

  // Future updateUser(UserProfile user ) async {
  //   try {
  //     await _userCollection
  //         .doc(user.id)
  //         .update(user.toJson());

  //   } catch (e) {
  //     if (e is PlatformException) {
  //       return e.message;
  //     }

  //     return e.toString();
  //   }
  // }

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
