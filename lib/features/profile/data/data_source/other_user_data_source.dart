import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';

abstract interface class OtherUserDataSource {
  Future<AppUser> getOtherUserProfile(String uid);
  Future<void> followUser(String currentUid, String otherUid);
  Future<void> unfollowUser(String currentUid, String otherUid);
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByOtherUser(String userId);
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
      throw const MainException();
    }
  }

  @override
  Future<void> followUser(String currentUid, String otherUid) async {
    try {
      throw Exception();

      // await Future.delayed(Duration(seconds: 2));
      // throw Exception();
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
      throw Exception();
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
}
