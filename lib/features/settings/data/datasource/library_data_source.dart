import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/common/models/post_model.dart';
import '../../../../core/const/fireabase_const/firebase_collection.dart';
import '../../../../core/errors/exception.dart';

abstract interface class LibraryDataSource {
  Future<List<PostModel>> getSavedPosts({required List<String> savedPosts});
  Future<List<PostModel>> getLikedPosts({required String myId});
}

class LibraryDataSourceImpl implements LibraryDataSource {
  final FirebaseFirestore _firebaseFirestore;

  LibraryDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<List<PostModel>> getSavedPosts(
      {required List<String> savedPosts}) async {
    try {
      final postRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.posts);
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);
      List<PostModel> posts = [];

      // Batch size for Firestore query limitations
      const batchSize = 30;

      // Process posts in batches
      for (int i = 0; i < savedPosts.length; i += batchSize) {
        final batchIds = savedPosts.skip(i).take(batchSize).toList();
        final QuerySnapshot<Map<String, dynamic>> batchPosts =
            await postRef.where('postId', whereIn: batchIds).get();

        for (var post in batchPosts.docs) {
          final userDoc = await userRef.doc(post['creatorUid']).get();
          if (!userDoc.exists) continue;
          final PartialUser user = PartialUser.fromJson(userDoc.data()!);
          final currentPost = PostModel.fromJson(post.data(), user);
          posts.add(currentPost);
        }
      }

      return posts;
    } catch (e) {
      log('error is ${e.toString()}');
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> getLikedPosts({required String myId}) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    try {
      // Reference to the user's likedPosts subcollection
      final likedPostsRef = userCollection.doc(myId).collection('likedPosts');

      // Fetch all liked post references
      final likedPostsSnapshot = await likedPostsRef.get();
      log(likedPostsSnapshot.docs.toString());
      if (likedPostsSnapshot.docs.isEmpty) {
        return [];
      }

      final likedPostIds =
          likedPostsSnapshot.docs.map((doc) => doc.id).toList();
      final postRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.posts);

      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      const batchSize = 30;
      for (int i = 0; i < likedPostIds.length; i += batchSize) {
        final batchIds = likedPostIds.skip(i).take(batchSize).toList();
        final QuerySnapshot<Map<String, dynamic>> batchPosts =
            await postRef.where('postId', whereIn: batchIds).get();

        for (var post in batchPosts.docs) {
          final userDoc = await userRef.doc(post['creatorUid']).get();
          if (!userDoc.exists) continue;
          final PartialUser user = PartialUser.fromJson(userDoc.data()!);
          final currentPost = PostModel.fromJson(post.data(), user);
          posts.add(currentPost);
        }
      }
      return posts;
    } catch (e) {
      log('error is ${e.toString()}');
      throw const MainException();
    }
  }
}
