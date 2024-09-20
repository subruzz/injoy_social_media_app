import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';

import '../../../../core/utils/di/di.dart';

abstract class UserDataDatasource {
  Future<List<PostModel>> getAllPostsByUser(PartialUser user);
  Future<List<PostModel>> getMyLikedPosts(String myId);
  Future<List<PostModel>> getShorts(PartialUser user);
  Future<List<PartialUser>> getMyFollowing(List<String> following, String myId);
  Future<List<PartialUser>> getMyFollowers(String myId);
}

class UserDataDatasourceImpl implements UserDataDatasource {
  @override
  Future<List<PostModel>> getAllPostsByUser(PartialUser user) async {
    try {
      return await serviceLocator<FirebaseHelper>()
          .getAllPostsOrReelsOfuser(user);
    } catch (e) {
      log(e.toString());
      throw const MainException();
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

  @override
  Future<List<PostModel>> getMyLikedPosts(String myId) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final postCollection = FirebaseFirestore.instance.collection('posts');

    try {
      // Reference to the user's likedPosts subcollection
      final likedPostsRef = userCollection.doc(myId).collection('likedPosts');

      // Fetch all liked post references
      final likedPostsSnapshot = await likedPostsRef.get();
      if (likedPostsSnapshot.docs.isEmpty) {
        return [];
      }
      return [];

      // Extract the post IDs from the liked posts
      // final likedPostIds =
      //     likedPostsSnapshot.docs.map((doc) => doc.id).toList();

      // // Fetch the details of all liked posts from the posts collection
      // final postFutures = likedPostIds.map((postId) async {
      //   final postSnapshot = await postCollection.doc(postId).get();
      //   if (postSnapshot.exists) {
      //     return PostModel.fromJson(
      //         postSnapshot.data()!); // Ensure non-null data
      //   }
      //   return null; // Explicitly handle non-existent posts
      // }).toList();

      // // Wait for all post details to be fetched
      // final posts = await Future.wait(postFutures);

      // // Filter out any null values (in case some posts were deleted)
      // return posts.where((post) => post != null).cast<PostModel>().toList();
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> getShorts(PartialUser user) async {
    try {
      return await serviceLocator<FirebaseHelper>()
          .getAllPostsOrReelsOfuser(user, isShorts: true);
    } catch (e) {
      log('erris is ${e.toString()}');
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }
}
