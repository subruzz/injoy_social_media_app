import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_storage_const.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/services/firebase/firebase_storage.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/explore/data/model/explore_seearch_location_model.dart';
import 'package:social_media_app/features/post/data/models/update_post_model.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

abstract interface class PostRemoteDatasource {
  Future<void> createPost(
      PostEntity post, List<SelectedByte> postImage, bool isReel);
  Future<void> updatePost(
    UpdatePostEntity post,
    String pId,
  );
  Future<void> deletePost(String postId, bool isReel);
  Future<void> likePost(String postId, String currentUserUid, bool isReel);
  Future<void> unLikePost(String postId, String currentUserUid, bool isReel);
  Future<void> savePosts(String postId);

  Future<List<HashTag>> searchHashTags(String query);
}

class PostRemoteDataSourceImpl implements PostRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  PostRemoteDataSourceImpl(
      {required this.firestore, required this.firebaseStorage});

  @override
  Future<void> createPost(
      PostEntity post, List<SelectedByte> postImage, bool isReel) async {
    if (postImage.isEmpty) return;
    final postCollection = FirebaseFirestore.instance.collection(
        isReel ? FirebaseCollectionConst.reels : FirebaseCollectionConst.posts);
    final hashtagCollection =
        FirebaseFirestore.instance.collection(FirebaseCollectionConst.hashTags);
    final locationCollection = FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.locations);

    try {
      final refToAsset = !isReel
          ? '${FirebaseFirestoreConst.postPath}/${post.creatorUid}/${FirebaseFirestoreConst.postPath}'
          : '${FirebaseFirestoreConst.reelPath}/${post.creatorUid}/${FirebaseFirestoreConst.reelPath}';
      final assetItem = await serviceLocator<FirebaseStorageService>()
          .uploadListOfAssets(
              assets: postImage,
              reference: refToAsset,
              isPhoto: !isReel,
              needThumbnail: isReel);
      if ((isReel && assetItem.url == null) ||
          !isReel && assetItem.urls.isEmpty) {
        log('here');
        throw const MainException();
      }
      final newPost = PostModel(
          isEdited: false,
          likesCount: 0,
          extra: assetItem.extra,
          isCommentOff: post.isCommentOff,
          userFullName: post.userFullName,
          postId: post.postId,
          creatorUid: post.creatorUid,
          createAt: Timestamp.now(),
          username: post.username,
          description: post.description,
          likes: const [],
          totalComments: 0,
          latitude: post.latitude,
          longitude: post.longitude,
          location: post.location,
          hashtags: post.hashtags,
          userProfileUrl: post.userProfileUrl,
          postImageUrl: isReel ? [assetItem.url!] : assetItem.urls);

      final hashtags = post.hashtags;
      // Update the hashtags collection
      for (String hashtag in hashtags) {
        final hashtagRef = hashtagCollection.doc(hashtag);
        final postRef = hashtagRef.collection('postIds').doc(post.postId);

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(hashtagRef);
          if (!snapshot.exists) {
            transaction.set(hashtagRef,
                {'count': FieldValue.increment(1), 'hashtagName': hashtag});
          } else {
            transaction.update(hashtagRef, {
              'count': FieldValue.increment(1),
            });
          }

          transaction.set(postRef, {
            'postId': post.postId,
          });
        });
      }
      final locationName = post.location;

      if (post.location != null && post.location != '') {
        final locationRef = locationCollection.doc(locationName);
        final postRef = locationRef.collection('postIds').doc(post.postId);

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(locationRef);
          final location = SearchLocationModel(
            latitude: post.latitude,
            longitude: post.longitude,
            locationName: locationName!,
            count: 1,
          );
          if (!snapshot.exists) {
            transaction.set(locationRef, location.toJson());
          } else {
            transaction.update(locationRef, {
              'count': FieldValue.increment(1),
            });
          }

          transaction.set(postRef, {
            'postId': post.postId,
          });
        });
      }
      await postCollection.doc(post.postId).set(newPost.toJson());
    } catch (e) {
      log('error is this ${e.toString()}');
      throw MainException(
          errorMsg: 'Error creating post', details: e.toString());
    }
  }

  @override
  Future<void> updatePost(
    UpdatePostEntity post,
    String postId,
  ) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');

    try {
      final newPost = UpdatePostModel(
        description: post.description,
        hashtags: post.hashtags,
      );
      await postCollection.doc(postId).update(newPost.toJson());
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error updating post',
          details:
              'There was an erro occured during updating the post,Please try again!');
    }
  }

  @override
  Future<void> deletePost(String postId, bool isReel) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    try {
      postCollection.doc(postId).delete();
    } catch (e) {
      throw const MainException(errorMsg: 'Error while deleting the post');
    }
  }

  @override
  Future<void> unLikePost(
      String postId, String currentUserUid, bool isReel) async {
    final postCollection =
        FirebaseFirestore.instance.collection(isReel ? 'reels' : 'posts');

    final userCollection = FirebaseFirestore.instance.collection('users');

    try {
      final postRef = postCollection.doc(postId);
      final userRef = userCollection.doc(currentUserUid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final postSnapshot = await transaction.get(postRef);
        final userSnapshot = await transaction.get(userRef);

        if (!postSnapshot.exists || !userSnapshot.exists) {
          throw Exception("Post or user does not exist!");
        }

        // Update post's likes array and decrement likes count
        transaction.update(postRef, {
          'likes': FieldValue.arrayRemove([currentUserUid]),
          'likesCount': FieldValue.increment(-1),
        });

        // Remove post from user's likedPosts subcollection
        final userLikesSubCollectionRef =
            userRef.collection('likedPosts').doc(postId);
        transaction.delete(userLikesSubCollectionRef);
      });
    } catch (e) {
      log('shite');
      throw const MainException();
    }
  }

  @override
  Future<void> likePost(
      String postId, String currentUserUid, bool isReel) async {
    final postCollection =
        FirebaseFirestore.instance.collection(isReel ? 'reels' : 'posts');

    final userCollection = FirebaseFirestore.instance.collection('users');

    try {
      final postRef = postCollection.doc(postId);
      final userRef = userCollection.doc(currentUserUid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final postSnapshot = await transaction.get(postRef);
        final userSnapshot = await transaction.get(userRef);

        if (!postSnapshot.exists || !userSnapshot.exists) {
          throw Exception("Post or user does not exist!");
        }

        // Update post's likes array and increment likes count
        transaction.update(postRef, {
          'likes': FieldValue.arrayUnion([currentUserUid]),
          'likesCount': FieldValue.increment(1),
        });

        // Add post to user's likedPosts subcollection
        final userLikesSubCollectionRef =
            userRef.collection('likedPosts').doc(postId);
        transaction.set(userLikesSubCollectionRef, {
          'postId': postId,
          'likedAt': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      log('shite ${e.toString()}');

      throw const MainException();
    }
  }

  @override
  Future<List<HashtagModel>> searchHashTags(String query) async {
    try {
      final hashTagCollection =
          FirebaseFirestore.instance.collection('hashtags');
      final querySnapshot = await hashTagCollection
          .where('hashtagName', isGreaterThanOrEqualTo: query)
          .where('hashtagName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Convert the query results to a list of AppUserModel
      final hashTags = querySnapshot.docs
          .map((doc) => HashtagModel.fromJson(doc.data()))
          .toList();
      return hashTags;
    } catch (e) {
      throw MainException(details: e.toString());
    }
  }

  @override
  Future<void> savePosts(String postId) async {
    final myId = FirebaseAuth.instance.currentUser?.uid;
    if (myId == null) {
      throw const MainException(errorMsg: "User not authenticated.");
    }

    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDoc = userCollection.doc(myId);

    try {
      // Get the current document snapshot
      final docSnapshot = await userDoc.get();
      final savedPosts = docSnapshot.get('savedPosts') as List<dynamic>? ?? [];

      // Check if postId is already in the savedPosts array
      final isPostSaved = savedPosts.contains(postId);

      if (isPostSaved) {
        // Remove postId from savedPosts if it exists
        await userDoc.update({
          'savedPosts': FieldValue.arrayRemove([postId]),
        });
      } else {
        // Add postId to savedPosts if it doesn't exist
        await userDoc.update({
          'savedPosts': FieldValue.arrayUnion([postId]),
        });
      }
    } catch (e) {
      log('error iffs ${e.toString()}');
      throw const MainException();
    }
  }
}
