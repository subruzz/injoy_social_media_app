import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/features/create_post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:uuid/uuid.dart';

abstract interface class PostRemoteDatasource {
  Future<void> createPost(PostEntity post, List<File?> postImage);
  Future<List<PostEntity>> getAllPosts(String uid);
  Future<void> updatePost(PostEntity post, List<File?> postImage);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);
  Future<String?> getCurrentUserId();
  Future<List<HashTag>> searchHashTags(String query);
  Future<List<String>> uploadUserImage(List<File?> postImages, String pId);
}

class PostRemoteDataSourceImpl implements PostRemoteDatasource {
  @override
  Future<String?> getCurrentUserId() async {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Future<void> createPost(PostEntity post, List<File?> postImage) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    final hashtagCollection = FirebaseFirestore.instance.collection('hashtags');

    try {
      final postUrls = await uploadUserImage(postImage, post.postId);
      final newPost = PostModel(
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
      print(e.toString());
      throw MainException(
          errorMsg: 'Error creating post', details: e.toString());
    }
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');

    try {
      postCollection.doc(post.postId).delete();
    } catch (e) {
      throw const MainException(errorMsg: 'Error while deleting the post');
    }
  }

  @override
  Future<List<PostEntity>> getAllPosts(String uid) {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');
    try {
      final currentUserUid = await getCurrentUserId();
      final postRef = await postCollection.doc(post.postId).get();
      if (postRef.exists) {
        List likes = postRef.get('likes');
        if (likes.contains(currentUserUid)) {
          postCollection.doc(post.postId).update({
            'likes': FieldValue.arrayRemove([currentUserUid])
          });
        } else {
          postCollection.doc(post.postId).update({
            'likes': FieldValue.arrayUnion([currentUserUid])
          });
        }
      }
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
  Future<void> updatePost(PostEntity post, List<File?> postImage) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');

    try {
      final postUrls = await uploadUserImage(postImage, post.postId);
      final newPost = PostModel(
          userFullName: post.userFullName,
          postId: post.postId,
          creatorUid: post.creatorUid,
          createAt: Timestamp.now(),
          username: post.username,
          description: post.description,
          likes: const [],
          latitude: post.latitude,
          longitude: post.longitude,
          location: post.location,
          totalComments: 0,
          hashtags: post.hashtags,
          userProfileUrl: post.userProfileUrl,
          postImageUrl: [...post.postImageUrl, ...postUrls]);
      await postCollection.doc(post.postId).update(newPost.toJson());
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error updating post',
          details:
              'There was an erro occured during updating the post,Please try again!');
    }
  }

  @override
  Future<List<String>> uploadUserImage(
      List<File?> postImages, String pId) async {
    try {
      if (postImages.isEmpty) {
        return [];
      }
      final FirebaseStorage storage = FirebaseStorage.instance;
      List<String> postImageUrls = [];
      Reference ref = storage.ref().child('posts').child(pId);
      for (var image in postImages) {
        if (image == null) continue;
        UploadTask task = ref.child(const Uuid().v4()).putFile(image);
        TaskSnapshot snapshot = await task;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        postImageUrls.add(downloadUrl);
      }
      return postImageUrls;
    } catch (e) {
      throw const MainException(
          errorMsg: 'Error while setting profile Picture ');
    }
  }
}
