import 'package:bloc_app_template/blocs/base_bloc.dart';
import 'package:bloc_app_template/models/story.dart';
import 'package:bloc_app_template/services/dialog_service.dart';
import 'package:bloc_app_template/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';

class StoriesBloc extends BaseBloc {
  static final _firestoreService = locator<FirestoreService>();
  static final _dialogService = locator<DialogService>();

  /*
   * UI Logic
   */

  final String _title = 'Top Stories';
  String get title => _title;

  List<Story> _stories = [];
  List<Story> get stories => _stories;

  Future setUp() async {
    await _getStoriesHelper(userId: currentUser.id);
  }

  Future getStories() async {
    await _getStoriesHelper(userId: currentUser.id);
  }

  /*
   * Actual Logic
   */

  Future _getStoriesHelper({@required String userId}) async {
    setBusy = true;
    var firestoreResult = await _firestoreService.getStories(userId: userId);
    setBusy = false;

    if (firestoreResult is DocumentSnapshot) {
      if (firestoreResult.data == null) {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'No stories for this user!',
          buttonTitle: 'Ok',
        );
      } else {
        firestoreResult.data.forEach((key, value) {
          var newStory = Story.fromData(value);
          _stories.add(newStory);
        });
        notifyListeners();
      }
    } else {
      await _dialogService.showDialog(
        title: 'Error Getting the stories',
        description: 'There was an error!',
        buttonTitle: 'Ok',
      );
    }
  }
}
