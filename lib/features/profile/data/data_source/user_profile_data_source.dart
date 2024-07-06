import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_field_const.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_storage_const.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/profile/data/model/user_profile_model.dart';

abstract interface class UserProfileDataSource {
  Future<AppUser> createUserProfile(
      {required UserProfileModel userProfile, required String uid, File? file});
  Future<String> uploadUserImage(File profileImage, String uid);
  Future<bool> checkUserNameExist(String userName);
  Future<void> addInterest(List<String> interests, String uid);
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  UserProfileDataSourceImpl(
      {required FirebaseStorage firebaseStorage,
      required FirebaseFirestore firebaseFirestore})
      : _firebaseStorage = firebaseStorage,
        _firebaseFirestore = firebaseFirestore;
  @override
  Future<AppUser> createUserProfile(
      {required UserProfileModel userProfile,
      required String uid,
      File? file}) async {
    try {
      String? userImage;
      //if user profile is selected uploading to firebase storage
      if (file != null) {
        userImage = await uploadUserImage(file, uid);
        //updating the model with new userimage;
        userProfile = userProfile.copyWith(profilePic: userImage);
      }
      //updating the user details inthe firebase

      await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .update(
            userProfile.toJson(),
          );
      DocumentSnapshot docSnapshot = await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .get();
      //return the latest user details
      return AppUserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      log('exception while creating the user');
      throw const MainException(
          errorMsg: AppErrorMessages.profileCreateFailure);
    }
  }

  @override
  Future<void> addInterest(List<String> interests, String uid) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .update({'interests': interests, 'viewedSetupIndex': 1});
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<bool> checkUserNameExist(String userName) async {
    try {
      //getting the user collection based on the queried name
      final QuerySnapshot result = await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .where(FirebaseFieldConst.userName, isEqualTo: userName)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      //return if its available by checking document is empty or not
      return documents.isEmpty;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<String> uploadUserImage(File profileImag, String uid) async {
    try {
      //geting the ref to profile using user id
      Reference ref = _firebaseStorage
          .ref()
          .child(FirebaseFirestoreConst.userImages)
          .child(uid);
      UploadTask task = ref.putFile(profileImag);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      //return the download url
      return downloadUrl;
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error while setting profile Picture ');
    }
  }
}
