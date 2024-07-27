import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';

abstract interface class OtherUserDataSource {
  Future<AppUser> getOtherUserProfile(String uid);
  Future<void> followUser(String currentUid, String otherUid);
  Future<void> unfollowUser(String currentUid, String otherUid);
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByOtherUser(String userId);
  Future<List<PartialUser>> getMyFollowing(List<String> following, String myId);
  Future<List<PartialUser>> getMyFollowers(String myId);
}

class OtherUserDataSourceImpl implements OtherUserDataSource {
  final FirebaseFirestore _firebaseFirestore;
  // final LRUCache<String, AppUser> _cachedUser = LRUCache(100);
  OtherUserDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Future<AppUser> getOtherUserProfile(String uid) async {
    try {
      DocumentSnapshot docSnapshot = await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .get();
      if (!docSnapshot.exists) {
        throw Exception();
      }
      final user =
          AppUserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      // _cachedUser.set(uid, user);
      return user;
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

  @override
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByOtherUser(String userId) async {
    try {
      final posts = await FirebaseFirestore.instance
          .collection('posts')
          .where("creatorUid", isEqualTo: userId)
          .orderBy('createAt', descending: true)
          .get();
      List<String> postImages = [];
      final userAllPosts = posts.docs.map((posts) {
        if (posts['postImageUrl'] != null && posts['postImageUrl'] is List) {
          final currentPostImages = List<String>.from(posts['postImageUrl']);
          postImages.addAll(currentPostImages);
        }
        return PostModel.fromJson(
          posts.data(),
        );
      }).toList();
      return (userPosts: userAllPosts, userPostImages: postImages);
    } catch (e) {
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }

  @override
  Future<List<PartialUser>> getMyFollowers(
    String myId,
  ) async {
    try {
      // Fetch the follower IDs from the subcollection
      var followersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .collection('followers')
          .get();
      log('followers list are $followersSnapshot');
      // Extract the follower IDs
      List<String> followerIds =
          followersSnapshot.docs.map((doc) => doc.id).toList();

      if (followerIds.isNotEmpty) {
        // Fetch the user details for the follower IDs
        var userDetailsSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId, whereIn: followerIds)
            .get();

        // Map the query results to a list of PartialUser objects
        List<PartialUser> followers = userDetailsSnapshot.docs.map((doc) {
          var data = doc.data();
          return PartialUser.fromJson(data);
        }).toList();

        return followers;
      } else {
        return [];
      }
    } catch (e) {
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }

  @override
  Future<List<PartialUser>> getMyFollowing(
      List<String> following, String myId) async {
    try {
      if (following.isNotEmpty) {
        // Query the users collection for the user IDs in the following list
        var userDetailsSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId, whereIn: following)
            .get();

        // Map the query results to a list of PartialUser objects
        List<PartialUser> followingUsers = userDetailsSnapshot.docs.map((doc) {
          var data = doc.data();
          return PartialUser.fromJson(data);
        }).toList();

        return followingUsers;
      } else {
        return [];
      }
    } catch (e) {
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }
}
