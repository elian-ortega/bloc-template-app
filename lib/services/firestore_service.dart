import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class FirestoreService {
  final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  Future createUser(User user) async {
    try {
      await _userCollection.add(user.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }
}
