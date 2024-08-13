import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

abstract interface class OtherUserDataSource {
  Future<AppUser> getOtherUserProfile(String uid);
  Future<void> followUser(String currentUid, String otherUid);
  Future<void> unfollowUser(String currentUid, String otherUid);
 
}

class OtherUserDataSourceImpl implements OtherUserDataSource {
  final FirebaseFirestore _firebaseFirestore;
  // final LRUCache<String, AppUser> _cachedUser = LRUCache(100);
  OtherUserDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Future<AppUser> getOtherUserProfile(String uid) async {
    try {
      return await serviceLocator<FirebaseHelper>().getUserDetailsFuture(uid);
    } catch (e) {
      log('error is this ${e.toString()}');
      throw const MainException();
    }
  }

  @override
  Future<void> followUser(String currentUid, String otherUid) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(otherUid)
          .update({
        'followers': FieldValue.arrayUnion([currentUid])
      });
      await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(currentUid)
          .update({
        'following': FieldValue.arrayUnion([otherUid])
      });
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<void> unfollowUser(String currentUid, String otherUid) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(otherUid)
          .update({
        'followers': FieldValue.arrayRemove([currentUid])
      });
      await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(currentUid)
          .update({
        'following': FieldValue.arrayRemove([otherUid])
      });
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  
}
