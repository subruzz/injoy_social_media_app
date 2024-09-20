import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_storage_const.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/services/firebase/firebase_storage.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/explore/data/model/explore_seearch_location_model.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';

import '../../../../../core/utils/di/di.dart';

abstract interface class PostRemoteDatasource {
  Future<void> createPost(PostEntity post, List<SelectedByte> postImage,
      List<Uint8List>? postImgesFromWeb, bool isReel);
  Future<PostModel> updatePost(
    UpdatePostEntity post,
    PartialUser postUser,
    String pId,
  );
  Future<void> deletePost(PostEntity post);
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
  Future<void> createPost(PostEntity post, List<SelectedByte> postImage,
      List<Uint8List>? postImgesFromWeb, bool isReel) async {
    if (isThatMobile && postImage.isEmpty) return;
    final postCollection =
        FirebaseFirestore.instance.collection(FirebaseCollectionConst.posts);
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
              postImgesFromWeb: postImgesFromWeb,
              assets: postImage,
              reference: refToAsset,
              isPhoto: !isReel,
              needThumbnail: isReel);
      if (isThatMobile && (isReel && assetItem.url == null) ||
          isThatMobile && !isReel && assetItem.urls.isEmpty) {
        log('here');
        throw const MainException();
      }

      final newPost = PostModel(
          isThatvdo: isReel,
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
  Future<PostModel> updatePost(
    UpdatePostEntity post,
    PartialUser postUser,
    String postId,
  ) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    final hashtagCollection = FirebaseFirestore.instance.collection('hashtags');

    try {
      // Update the post in Firestore
      await postCollection.doc(postId).update(post.toJson());

      // Get updated post data
      final updatedPostSnapshot = await postCollection.doc(postId).get();
      final updatedPostData = updatedPostSnapshot.data();

      if (updatedPostData == null) {
        throw Exception("Post not found.");
      }

      // Handle hashtag updates
      final Set<String> newHashtags = Set.from(post.hashtags);
      final Set<String> oldHashtags = Set.from(post.oldPostHashtags);

      final Set<String> hashtagsToAdd = newHashtags.difference(oldHashtags);
      final Set<String> hashtagsToRemove = oldHashtags.difference(newHashtags);

      // Add new hashtags
      for (String hashtag in hashtagsToAdd) {
        final hashtagDoc = hashtagCollection.doc(hashtag);
        final hashtagSnapshot = await hashtagDoc.get();

        if (hashtagSnapshot.exists) {
          await hashtagDoc.update({
            'count': FieldValue.increment(1),
          });
        } else {
          await hashtagDoc.set({
            'count': 1,
          });
        }
      }

      // Remove old hashtags
      for (String hashtag in hashtagsToRemove) {
        final hashtagDoc = hashtagCollection.doc(hashtag);
        final hashtagSnapshot = await hashtagDoc.get();

        if (hashtagSnapshot.exists) {
          final currentCount = hashtagSnapshot['count'] as int;
          if (currentCount > 1) {
            await hashtagDoc.update({
              'count': FieldValue.increment(-1),
            });
          } else {
            await hashtagDoc.delete();
          }
        }
      }

      // Return the updated post model
      return PostModel.fromJson(updatedPostData, postUser);
    } catch (e) {
      log('e ${e.toString()}');
      throw const MainException();
    }
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    final hashtagsCollection =
        FirebaseFirestore.instance.collection('hashtags');
    final locationsCollection =
        FirebaseFirestore.instance.collection('locations');

    try {
      // Start a batch to perform all deletions atomically
      final batch = FirebaseFirestore.instance.batch();

      // Delete the post document
      final postDoc = postCollection.doc(post.postId);
      batch.delete(postDoc);

      // Update hashtag counts
      if (post.hashtags.isNotEmpty) {
        for (var hashtag in post.hashtags) {
          final hashtagDoc = hashtagsCollection.doc(hashtag);
          final docSnapshot = await hashtagDoc.get();
          if (docSnapshot.exists) {
            final currentCount = docSnapshot.data()?['count'] ?? 0;
            if (currentCount > 1) {
              batch.update(hashtagDoc, {'count': currentCount - 1});
            } else {
              // Optionally delete the hashtag if count reaches 0
              batch.delete(hashtagDoc);
            }
          }
        }
      }

      // Update location count
      if (post.location != null) {
        final locationDoc = locationsCollection.doc(post.location);
        final docSnapshot = await locationDoc.get();
        if (docSnapshot.exists) {
          final currentCount = docSnapshot.data()?['count'] ?? 0;
          if (currentCount > 1) {
            batch.update(locationDoc, {'count': currentCount - 1});
          } else {
            // Optionally delete the location if count reaches 0
            batch.delete(locationDoc);
          }
        }
      }

      // Commit the batch operation
      await batch.commit();

      for (var media in post.postImageUrl) {
        await firebaseStorage.refFromURL(media).delete();
      }
      if (post.extra != null) {
        await firebaseStorage.refFromURL(post.extra!).delete();
      }
    } catch (e) {
      log('Error deleting the post: ${e.toString()}');
      throw const MainException(errorMsg: 'Error while deleting the post');
    }
  }

  @override
  Future<void> unLikePost(
      String postId, String currentUserUid, bool isReel) async {
    final postCollection =
        FirebaseFirestore.instance.collection(FirebaseCollectionConst.posts);
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
        FirebaseFirestore.instance.collection(FirebaseCollectionConst.posts);

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
    log('this called');
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
