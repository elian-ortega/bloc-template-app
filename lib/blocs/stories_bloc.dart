import 'package:bloc_app_template/blocs/base_bloc.dart';
import 'package:bloc_app_template/models/story.dart';
import 'package:bloc_app_template/services/dialog_service.dart';
import 'package:bloc_app_template/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';

class StoriesBloc extends BaseBloc {
  StoriesBloc() {
    print('NewBlocCreated');
    listenToStories();
  }

  static final _firestoreService = locator<FirestoreService>();
  static final _dialogService = locator<DialogService>();

  /*
   * UI Logic
   */

  final String _title = 'Top Stories';
  String get title => _title;

  List<Story> _stories = [];
  List<Story> get stories => _stories;

  // Future getStories() async {
  //   await _getStoriesHelper(userId: currentUser.id);
  // }

  void listenToStories() {
    _listenToStoriesHelper(userId: currentUser.id);
  }

  void deleteStory({@required int storyIndex}) {
    _deleteStoryHelper(userId: currentUser.id, storyId: _stories[storyIndex].storyId);
  }

  /*
   * Actual Logic
   */

  // Future _getStoriesHelper({@required String userId}) async {
  //   setBusy = true;
  //   var firestoreResult = await _firestoreService.getStories(userId: userId);
  //   setBusy = false;

  //   if (firestoreResult is DocumentSnapshot) {
  //     if (firestoreResult.data == null) {
  //       await _dialogService.showDialog(
  //         title: 'Error',
  //         description: 'No stories for this user!',
  //         buttonTitle: 'Ok',
  //       );
  //     } else {
  //       firestoreResult.data.forEach((key, value) {
  //         var newStory = Story.fromData(data: value, storyId: value);
  //         _stories.add(newStory);
  //       });
  //       notifyListeners();
  //     }
  //   } else {
  //     await _dialogService.showDialog(
  //       title: 'Error Getting the stories',
  //       description: 'There was an error!',
  //       buttonTitle: 'Ok',
  //     );
  //   }
  // }

  void _listenToStoriesHelper({@required String userId}) {
    setBusy = true;
    _firestoreService.getStoriesRealTime(userId: userId).listen(
      (storiesData) {
        var updatedStories = storiesData;
        if (updatedStories != null && updatedStories.isNotEmpty) {
          _stories = updatedStories;
          notifyListeners();
        }
      },
    );
    setBusy = false;
  }

  Future<void> _deleteStoryHelper({@required String userId, @required String storyId}) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'After deleting the story is not going to be available!',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Delete',
    );

    if (dialogResponse.confirmed == true) {
      var deleteResult = await _firestoreService.deleteStory(storyId: storyId, userId: userId);

      if (deleteResult is String) {
        await _dialogService.showDialog(
          title: 'Error Deleting',
          description: 'There was an error when deleting the story!',
          buttonTitle: 'Ok',
        );
      }
    }
  }
}
