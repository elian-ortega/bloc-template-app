import 'package:bloc_app_template/locator.dart';
import 'package:bloc_app_template/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firestoreService = locator<FirestoreService>();

  User _currentUser;

  User get currentUser => _currentUser;

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
      // if (e is PlatformException) return e.message;
      // return e.toString();
      return e.message;
    }
  }
}
