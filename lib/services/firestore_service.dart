import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/post.dart';

class FirestoreService {
  static final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static final CollectionReference _postsCollection =
      Firestore.instance.collection('posts');

  /*
   * User Related
   */
  Future createUser(User user) async {
    try {
      await _userCollection.document(user.id).setData(user.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getUserData(String uid) async {
    try {
      var userData = await _userCollection.document(uid).get();
      print(userData.data);
      return User.fromMap(userData.data);
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  /*
   * Posts Related
   */

  Future createPost({@required Post post}) async {
    try {
      await _postsCollection.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }
}
