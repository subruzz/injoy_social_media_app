import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_storage_const.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/utils/compress_image.dart';
import 'package:social_media_app/core/utils/id_generator.dart';
import 'package:social_media_app/features/explore/data/model/explore_seearch_location_model.dart';
import 'package:social_media_app/features/post/data/models/update_post_model.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';

abstract interface class PostRemoteDatasource {
  Future<void> createPost(PostEntity post, List<AssetEntity> postImage);
  Future<PostModel> updatePost(
    UpdatePostEntity post,
    String pId,
  );
  Future<void> deletePost(String postId);
  Future<void> likePost(String postId, String currentUserUid);
  Future<void> unLikePost(String postId, String currentUserUid);

  Future<String?> getCurrentUserId();
  Future<List<HashTag>> searchHashTags(String query);
  Future<List<String>> uploadPostImages(
      List<AssetEntity> postImages, String pId);
}

class PostRemoteDataSourceImpl implements PostRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  PostRemoteDataSourceImpl(
      {required this.firestore, required this.firebaseStorage});
  @override
  Future<String?> getCurrentUserId() async {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Future<void> createPost(PostEntity post, List<AssetEntity> postImage) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    final hashtagCollection = FirebaseFirestore.instance.collection('hashtags');
    final locationCollection =
        FirebaseFirestore.instance.collection('locations');

    try {
      final postUrls = await uploadPostImages(postImage, post.postId);
      final newPost = PostModel(
          isEdited: false,
          likesCount: 0,
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
          postImageUrl: postUrls);

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
      throw MainException(
          errorMsg: 'Error creating post', details: e.toString());
    }
  }

  @override
  Future<PostModel> updatePost(
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
      final updatedPostSnapshot = await postCollection.doc(postId).get();
      return PostModel.fromJson(
          updatedPostSnapshot.data() as Map<String, dynamic>); //
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error updating post',
          details:
              'There was an erro occured during updating the post,Please try again!');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    try {
      postCollection.doc(postId).delete();
    } catch (e) {
      throw const MainException(errorMsg: 'Error while deleting the post');
    }
  }

  @override
  Future<void> unLikePost(String postId, String currentUserUid) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
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
      throw const MainException();
    }
  }

  @override
  Future<void> likePost(String postId, String currentUserUid) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
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
      throw const MainException();
    }
  }

  @override
  Future<List<HashtagModel>> searchHashTags(String query) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('hashtags')
          .where('hashtagName', isGreaterThanOrEqualTo: query)
          .where('hashtagName', isLessThan: '${query}z')
          .get();

      return snapshot.docs
          .map((doc) => HashtagModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw MainException(details: e.toString());
    }
  }

  @override
  Future<List<String>> uploadPostImages(
      List<AssetEntity> postImages, String uId) async {
    try {
      //if not status images is picked return empty list
      if (postImages.isEmpty) {
        return [];
      }
      Reference ref = firebaseStorage
          .ref()
          .child(FirebaseFirestoreConst.postImages)
          .child(uId);
      List<String> postImageUrls = [];

      for (var image in postImages) {
        //get the  file from the AssetEntity
        File? file = await image.file;
        if (file == null) continue;
        // Compress the image; resulting type will be Uint8List
        final data = await compressFile(file);
        if (data == null) continue;
        //generating unique id
        String imageId = IdGenerator.generateUniqueId();
        // Upload the compressed image data to Firebase Storage
        UploadTask task = ref.child(imageId).putData(data);
        TaskSnapshot snapshot = await task;

        String downloadUrl = await snapshot.ref.getDownloadURL();
        postImageUrls.add(downloadUrl);
      }

      return postImageUrls;
    } catch (e) {
      throw Exception();
    }
  }
}
