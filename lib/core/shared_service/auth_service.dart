import 'package:client/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import 'package:client/core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:client/injection.dart';

@singleton
class AuthService {
  final _auth = FirebaseAuth.instance;
  UserProfile? _currentUser = null;

  AuthService();
  UserProfile? get currentUser => _currentUser;
  User? get currentUserDetails => _auth.currentUser;

  Future signUpWithEmailPassword({email, password, name}) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Create nd Populate current user
      UserProfile user = UserProfile(
        id: authResult.user!.uid,
        email: email,
        name: name,
        photoUrl: "",
      );
      await getIt<UserService>().createUser(user);
      await _populateCurrentUser(authResult.user!);

      return authResult.user;
    } catch (error) {
      await getIt<DialogService>().showDialog(title: "Error", description: error.toString());
      return null;
    }
  }

  Future sendPasswordResetEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return e;
    }
  }

  Future changePassword(String currentPassword, String newpassword) async {
    try {
      User user = _auth.currentUser!;

      AuthCredential credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );
      var result = await user.reauthenticateWithCredential(credential);
      await result.user!.updatePassword(newpassword);
      return true;
    } catch (e) {
      await getIt<DialogService>().showDialog(title: "Error", description : e.toString());
      return null;
    }
  }

  Future signInWithEmailPassword(email, password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Populate current user
      await _populateCurrentUser(authResult.user!);
      return authResult.user;
    } catch (e) {
      await getIt<DialogService>().showDialog(title: "Error", description: e.toString());
      return null;
    }
  }

  // Future signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final authResult = await _auth.signInWithCredential(credential);
  //
  //     // Create nd Populate current user
  //     await _userService.createUser(UserProfile(
  //         email: authResult.user.email,
  //         name: authResult.user.displayName,
  //         photoUrl: authResult.user.photoURL));
  //     await _populateCurrentUser(authResult.user);
  //
  //     print("User : " + authResult.user.displayName);
  //     return authResult.user;
  //   } on PlatformException {
  //     return "Something went wrong. Try again";
  //   } catch (e) {
  //     print("Error : " + e.code);
  //     return e.message;
  //   }
  // }

  Future checkUserLoginStatus() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) await _populateCurrentUser(firebaseUser);
    return firebaseUser != null;
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future _populateCurrentUser(User firebaseUser) async {
    if (firebaseUser != null) {
      UserProfile user = await getIt<UserService>().getUser(firebaseUser.uid);
      _currentUser = user;
    }
  }
}
