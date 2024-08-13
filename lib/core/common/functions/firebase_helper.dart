import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';

import '../../errors/exception.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore;

  FirebaseHelper({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Method to get user details as a stream
  Stream<AppUserModel> getUserDetailsStream(String userId) {
    return _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return AppUserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    });
  }

  // Method to get user details as a future
  Future<AppUserModel> getUserDetailsFuture(String userId) async {
    final doc = await _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(userId)
        .get();
    if (doc.exists && doc.data() != null) {
      return AppUserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception("User not found");
    }
  }

  //to get the partial detail of the user
  Future<PartialUser> getUserPartialDetails(String id) async {
    final userDoc = await FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.users)
        .doc(id)
        .get();
    if (!userDoc.exists) {
      throw const MainException();
    }
    return PartialUser.fromJson(userDoc.data()!);
  }
  //to get all post or shorts of user

  Future<List<PostModel>> getAllPostsOrReelsOfuser(PartialUser user,
      {bool isShorts = false}) async {
    final posts = await FirebaseFirestore.instance
        .collection('posts')
        .where("creatorUid", isEqualTo: user.id)
        .orderBy('createAt', descending: true).where('isThatvdo',isEqualTo: isShorts)
        .get();

    // Map the Firestore documents to PostModel objects
    final userAllPosts = posts.docs.map((post) {
      return PostModel.fromJson(post.data(), user);
    }).toList();

    return userAllPosts;
  }
}
