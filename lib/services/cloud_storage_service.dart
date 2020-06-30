import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:firebase_storage/firebase_storage.dart';

import '../models/cloud_storage_result.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpoad,
    @required String title,
  }) async {
    var imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();

    // Get the reference to the file we want to create
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    final uploadTask = firebaseStorageRef.putFile(imageToUpoad);
    final storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imgUrl: url,
        imageFileName: imageFileName,
      );
    }
    return null;
  }

  Future deleteImage(String imageFileName) async {
    if (imageFileName != null) {
      final firebaseStorageReference = FirebaseStorage.instance.ref().child(imageFileName);

      try {
        await firebaseStorageReference.delete();
      } catch (e) {
        return e.toString();
      }
    }
  }
}
