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
  Future<String> uploadUserImage(File? profileImage);
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  @override
  Future<AppUserModel> createUserProfile({
    required AppUser userProfile,
  }) async {
    final uid = await getCurrentUserToken();
    if (uid == null) {
      throw const MainException(errorMsg: 'User is not authenticated');
    }
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).update(
            userProfile.toJson(),
          );
      DocumentSnapshot docSnapshot =
          await firestore.collection('users').doc(uid).get();
      return AppUserModel.fromJson(
          docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
    
      throw const MainException(
          errorMsg: 'Error while creating profile please try again!');
    }
  }

  @override
  Future<String> uploadUserImage(File? profileImage) async {
    final uid = await getCurrentUserToken();
    if (uid == null) {
      throw const MainException(errorMsg: 'User is not authenticated');
    }
    try {
      if (profileImage == null) {
        throw const MainException(
            errorMsg: 'Error while setting profile Picture ');
      }
      final FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage.ref().child('UserProfile').child(uid);
      UploadTask task = ref.putFile(profileImage);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error while setting profile Picture ');
    }
  }
}
