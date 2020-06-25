import 'dart:async';

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

  final StreamController _postStreamController = StreamController<List<Post>>();
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
      var addResult = await _postsCollection.add(post.toMap());

      return addResult != null;
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Stream<List<Post>> listenToPost() {
    _postsCollection.snapshots().listen(
      (postSnapshot) {
        if (postSnapshot.documents.isNotEmpty) {
          var posts = postSnapshot.documents
              .map(
                (snapshot) => Post.fromData(
                  snapshot.data,
                  snapshot.documentID,
                ),
              )
              .where((mappedItem) => mappedItem != null)
              .toList();

          _postStreamController.add(posts);
        }
      },
    );

    return _postStreamController.stream;
  }
}
