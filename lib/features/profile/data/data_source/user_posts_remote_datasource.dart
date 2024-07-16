import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';

abstract class UserPostsRemoteDataSource {
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByUser(String userId);
  Future<List<PostModel>> getMyLikedPosts(String myId);
}

class UserPostsRemoteDatasourceImpl implements UserPostsRemoteDataSource {
  @override
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByUser(String userId) async {
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

      // Extract the post IDs from the liked posts
      final likedPostIds =
          likedPostsSnapshot.docs.map((doc) => doc.id).toList();

      // Fetch the details of all liked posts from the posts collection
      final postFutures = likedPostIds.map((postId) async {
        final postSnapshot = await postCollection.doc(postId).get();
        if (postSnapshot.exists) {
          return PostModel.fromJson(
              postSnapshot.data()!); // Ensure non-null data
        }
        return null; // Explicitly handle non-existent posts
      }).toList();

      // Wait for all post details to be fetched
      final posts = await Future.wait(postFutures);

      // Filter out any null values (in case some posts were deleted)
      return posts.where((post) => post != null).cast<PostModel>().toList();
    } catch (e) {
      throw const MainException();
    }
  }
}
