import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/utils/functions/firebase_functions.dart';
import 'package:social_media_app/features/profile/data/model/user_profile_model.dart';

abstract interface class UserProfileDataSource {
  Future<AppUser> createUserProfile({
    required AppUser userProfile,
  });
  Future<String> uploadUserImage(File? profileImage, String uid);
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  @override
  Future<AppUserModel> createUserProfile({
    required AppUser userProfile,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userProfile.id).update(
            userProfile.toJson(),
          );
      DocumentSnapshot docSnapshot =
          await firestore.collection('users').doc(userProfile.id).get();
      return AppUserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error while creating profile please try again!');
    }
  }

  @override
  Future<String> uploadUserImage(File? profileImag, String uid) async {
    try {
      if (profileImag == null) {
        throw const MainException(
            errorMsg: 'Error while setting profile Picture ');
      }
      final FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage.ref().child('UserProfile').child(uid);
      UploadTask task = ref.putFile(profileImag);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error while setting profile Picture ');
    }
  }
}
