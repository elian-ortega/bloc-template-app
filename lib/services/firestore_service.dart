import 'dart:async';

import 'package:bloc_app_template/models/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/post.dart';

class FirestoreService {
  static final CollectionReference _userCollection = Firestore.instance.collection('users');

  static final CollectionReference _postsCollection = Firestore.instance.collection('posts');

  static final CollectionReference _topStories = Firestore.instance.collection('topStories');

  final StreamController _postStreamController = StreamController<List<Post>>.broadcast();
  final StreamController _storiesStreamController = StreamController<List<Story>>.broadcast();
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

  Future editPost({@required String postId, @required Post post}) async {
    try {
      await _postsCollection.document(postId).setData(post.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future deletePost({@required String postId}) async {
    try {
      await _postsCollection.document(postId).delete();
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getPost({@required String postId}) async {
    try {
      var documentReference = await _postsCollection.document(postId);
      return documentReference.get();
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

/*
* Story Related
 */

  Future getStories({@required String userId}) async {
    try {
      var documentReference = await _topStories.document(userId);
      return documentReference.get();
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Stream<List<Story>> getStoriesRealTime({@required String userId}) {
    _topStories.document(userId).snapshots().listen(
      (storySnapshot) {
        var stories = <Story>[];
        storySnapshot.data.forEach((key, value) {
          var newStory = Story.fromData(value);
          stories.add(newStory);
        });
        print('AQUII');
        print(stories);
        _storiesStreamController.add(stories);
      },
    );
    return _storiesStreamController.stream;
  }
}
