import 'package:bloc_app_template/services/cloud_storage_service.dart';
import 'package:flutter/foundation.dart';

import 'base_bloc.dart';

import '../locator.dart';
import '../models/post.dart';

import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import '../services/authentication_service.dart';

import '../ui/router.dart';

class HomeBloc extends BaseBloc {
  static final _navigationService = locator<NavigationService>();
  static final _dialogService = locator<DialogService>();
  static final _authenticationService = locator<AuthenticationService>();
  static final _firestoreService = locator<FirestoreService>();
  static final _cloudStorageService = locator<CloudStorageService>();

  /*
   * UI 
   */

  List<Post> _posts;
  List<Post> get posts => _posts;

  final String _title = 'Home';
  String get title => _title;

  Future signOut() async {
    await _signOutHelper();
  }

  Future<void> navigateToAddPost() async {
    await _navigationService.navigateTo(Routes.addpost);
  }

  Stream<List<Post>> get postsStream => _firestoreService.listenToPost();

  Future editPost({@required String postId}) async {
    await _editPostHelper(postId: postId);
  }

  Future deletePost(
      {@required String postId, @required String imageFileName}) async {
    await _deletePostHelper(postId: postId, imageFileName: imageFileName);
  }

  /*
  * Acutal Logic
   */

  Future _signOutHelper() async {
    setBusy = true;
    await _authenticationService.signOut();
    setBusy = false;
    await _navigationService.replaceWith(Routes.login);
  }

  Future _editPostHelper({@required String postId}) async {
    setBusy = true;
    var postData = await _firestoreService.getPost(postId: postId);
    setBusy = false;

    if (postData != null) {
      var selectedPost = Post.fromData(postData.data, postId);
      await _navigationService.navigateTo(
        Routes.addpost,
        arguments: selectedPost,
      );
    } else {
      await _dialogService.showConfirmationDialog(
        title: 'Error Opening Post!',
        description:
            'There was an error opening the post please try again later.',
        confirmationTitle: 'Ok',
      );
    }
  }

  Future _deletePostHelper(
      {@required String postId, @required String imageFileName}) async {
    var confirmationResult = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Are you sure you want to delete this item?',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Delete',
    );

    if (confirmationResult.confirmed == true) {
      setBusy = true;
      var deleteResult = await _firestoreService.deletePost(postId: postId);
      await _cloudStorageService.deleteImage(imageFileName);
      setBusy = false;
      if (deleteResult is String) {
        await _dialogService.showDialog(
          title: 'Error Opening Post!',
          description:
              'There was an error deleting the post please try again later.',
          buttonTitle: 'Ok',
        );
      }
    }
  }
}
