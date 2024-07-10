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
import 'package:social_media_app/features/post/data/models/update_user_model.dart';
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

    try {
      final postUrls = await uploadPostImages(postImage, post.postId);
      final newPost = PostModel(
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
      for (var hashtag in hashtags) {
        DocumentReference hashtagRef = hashtagCollection.doc(hashtag);
        await hashtagRef.set({
          'name': hashtag,
          'posts': FieldValue.arrayUnion([post.postId])
        }, SetOptions(merge: true));
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
      final newPost = UpdateUserModel(
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

    await postCollection.doc(postId).update(({
          'likes': FieldValue.arrayRemove([currentUserUid])
        }));
  }

  @override
  Future<void> likePost(String postId, String currentUserUid) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    try {
      await postCollection.doc(postId).update(({
            'likes': FieldValue.arrayUnion([currentUserUid])
          }));
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<List<HashTagModel>> searchHashTags(String query) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('hashtags')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '${query}z')
          .get();

      return snapshot.docs
          .map((doc) => HashTagModel.fromJson(doc.data()))
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
