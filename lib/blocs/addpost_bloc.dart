import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_bloc.dart';

import '../locator.dart';
import '../models/post.dart';

import '../utils/image_selector.dart';

import '../services/cloud_storage_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import '../services/dialog_service.dart';

class AddPostBloc extends BaseBloc {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _imageSelector = locator<ImageSelector>();
  final _cloudStorageService = locator<CloudStorageService>();

  Post currentPost;

  bool _editingPost = false;
  bool get editingPost => _editingPost;

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  /*
   * UI 
   */

  void setUpEdit(Post postToEdit) {
    if (postToEdit != null) {
      _editingPost = true;
      currentPost = postToEdit;
    } else {
      currentPost = Post(imageUrl: null);
      _editingPost = false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final String _title = 'AddPost';
  String get title => _title;

  String _postTitle;
  String get postTitle => _postTitle;
  void setTitle(String value) {
    _postTitle = value;
    notifyListeners();
  }

  String _descritpion;
  String get descritpion => _descritpion;
  void setDescription(String value) {
    _descritpion = value;
    notifyListeners();
  }

  Future createPost() async {
    _formKey.currentState.save();
    final isValid = _formKey.currentState.validate();
    if (!_editingPost) {
      if (isValid) {
        await _createPostHelper(
          title: _postTitle,
          description: _descritpion,
        );
      }
    } else {
      if (isValid) {
        await _editPostHelper(
          postId: currentPost.postId,
          title: _postTitle,
          description: _descritpion,
        );
      }
    }
    _selectedImage = null;
  }

  /*
   * Actual Logic
   */

  Future _createPostHelper({
    @required String title,
    @required String description,
  }) async {
    setBusy = true;
    var storageResult;
    if (_selectedImage != null) {
      storageResult =
          await _cloudStorageService.uploadImage(imageToUpoad: _selectedImage, title: title);
    }

    var newPost = Post(
      userId: currentUser.id,
      userName: currentUser.fullName,
      title: title,
      description: description,
      imageUrl: storageResult == null ? storageResult : storageResult.imgUrl,
      imageFileName: storageResult == null ? storageResult : storageResult.imageFileName,
    );

    var addPostResult = await _firestoreService.createPost(post: newPost);

    setBusy = false;

    if (addPostResult is bool) {
      if (addPostResult) {
        await _navigationService.pop();
      } else {
        await _dialogService.showDialog(
          title: 'Post Creation Failed!',
          description: 'Please try again there was an erro when creating your post.',
          buttonTitle: 'Ok',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Post Creation Failed!',
        description: addPostResult,
        buttonTitle: 'Ok',
      );
    }
  }

  Future _editPostHelper({
    @required String postId,
    @required String title,
    @required String description,
  }) async {
    var newPost = Post(
      userId: currentUser.id,
      userName: currentUser.fullName,
      title: title,
      description: description,
    );

    setBusy = true;
    var editPostResult = await _firestoreService.editPost(post: newPost, postId: postId);
    setBusy = false;

    if (!(editPostResult is String)) {
      await _navigationService.pop();
    } else {
      await _dialogService.showDialog(
        title: 'Post Creation Failed!',
        description: editPostResult,
        buttonTitle: 'Ok',
      );
    }
  }
}
