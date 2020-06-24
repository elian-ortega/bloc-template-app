import 'package:bloc_app_template/locator.dart';
import 'package:bloc_app_template/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firestoreService = locator<FirestoreService>();

  User _currentUser;

  User get currentUser => _currentUser;

  Future<bool> isUserIn() async {
    var firebaseUser = await _firebaseAuth.currentUser();
    await _getCurrentUser(firebaseUser);
    return firebaseUser != null;
  }

  Future createUserWithEmail({
    @required fullName,
    @required email,
    @required password,
  }) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = User(
        id: authResult.user.uid,
        email: authResult.user.email,
        fullName: fullName,
      );

      // add user to firebase
      await _firestoreService.createUser(_currentUser);

      return authResult != null;
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future logInWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _getCurrentUser(authResult.user);

      return authResult != null;
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
  }

  Future _getCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUserData(user.uid);
    }
  }
}
