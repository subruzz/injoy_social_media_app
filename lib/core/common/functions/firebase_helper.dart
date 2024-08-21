import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/utils/other/cut_off_time.dart';

import '../../../features/notification/data/datacource/remote/device_notification.dart';
import '../../../features/notification/domain/entities/customnotifcation.dart';
import '../../../features/settings/domain/entity/ui_entity/enums.dart';
import '../../const/fireabase_const/firebase_field_const.dart';
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
  Future<AppUserModel?> getUserDetailsFuture(String userId) async {
    final doc = await _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(userId)
        .get();
    if (doc.exists && doc.data() != null) {
      return AppUserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  //to get the partial detail of the user
  Future<PartialUser?> getUserPartialDetails(String id) async {
    final userDoc = await FirebaseFirestore.instance
        .collection(FirebaseCollectionConst.users)
        .doc(id)
        .get();
    if (!userDoc.exists) {
      return null;
    }
    return PartialUser.fromJson(userDoc.data()!);
  }
  //to get all post or shorts of user

  Future<List<PostModel>> getAllPostsOrReelsOfuser(PartialUser user,
      {bool isShorts = false}) async {
    final posts = await FirebaseFirestore.instance
        .collection('posts')
        .where("creatorUid", isEqualTo: user.id)
        .orderBy('createAt', descending: true)
        .where('isThatvdo', isEqualTo: isShorts)
        .get();

    // Map the Firestore documents to PostModel objects
    final userAllPosts = posts.docs.map((post) {
      return PostModel.fromJson(post.data(), user);
    }).toList();

    return userAllPosts;
  }

  Future<List<PostModel>> getAllPostsOrShorts({
    String? excludeId,
    required String uId,
    bool isShorts = false,
  }) async {
    List<PostModel> reels = [];

    Query<Map<String, dynamic>> shortsRef = _firestore
        .collection('posts')
        .where('creatorUid', isNotEqualTo: uId)
        .orderBy('createAt', descending: true)
        .where('isThatvdo', isEqualTo: isShorts);

    // Fetch the posts
    final reelsQuerySnapshot = await shortsRef.get();

    // Iterate through the fetched posts
    for (var reelDoc in reelsQuerySnapshot.docs) {
      // If excludeId is provided, skip the document with matching postId
      if (excludeId != null && reelDoc['postId'] == excludeId) {
        continue; // Skip this iteration
      }

      final String creatorUid = reelDoc['creatorUid'];

      // Fetch the user associated with the post
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(creatorUid).get();

      if (userDoc.exists) {
        final PartialUser user = PartialUser.fromJson(userDoc.data()!);
        final PostModel reel = PostModel.fromJson(reelDoc.data(), user);
        reels.add(reel);
      }
    }

    return reels;
  }

  Future<void> deleteUnWantedStatus(String myId) async {
    final statusCollection =
        _firestore.collection(FirebaseCollectionConst.statuses);

    final cutoffTimestamp = cutOffTime;

    ///returning the list of statuses of current user from status collection using
    ///the user id
    final statuses = await statusCollection
        .where(FirebaseFieldConst.uId, isEqualTo: myId)
        .where(FirebaseFieldConst.createdAt, isLessThan: cutoffTimestamp)
        .get();
    for (var status in statuses.docs) {
      await status.reference.delete();
    }
  }

  Future<void> createNotification(
      {required CustomNotification notification,
      required NotificationPreferenceEnum notificationPreferenceType}) async {
    try {
      log('called notiication thing');
      AppUserModel? user = await getUserDetailsFuture(notification.receiverId);
      if (user == null) return;
      String token = user.token;
      log(token);
      log(user.notificationPreferences.isNotificationPaused.toString());

      if (user.notificationPreferences.isNotificationPaused) {
        return;
      }
      switch (notificationPreferenceType) {
        case NotificationPreferenceEnum.likes:
          if (user.notificationPreferences.isLikeNotificationPaused) {
            return; // Likes notifications are paused
          }
          break;
        case NotificationPreferenceEnum.comments:
          if (user.notificationPreferences.isCommentNotificationPaused) {
            return; // Comments notifications are paused
          }
          break;
        case NotificationPreferenceEnum.follow:
          if (user.notificationPreferences.isFollowNotificationPaused) {
            return; // Follow notifications are paused
          }
          break;
        case NotificationPreferenceEnum.messages:
          if (user.notificationPreferences.isMessageNotificationPaused) {
            return; // Messages notifications are paused
          }
          break;
        default:
          // Handle other cases or default behavior
          break;
      }

      if (token.isNotEmpty) {
        await DeviceNotification.sendNotificationToUser(
            deviceToken: token, notification: notification);
        await _createNotification(notification);
      }
    } catch (e) {
      log('error is this from the notification${e.toString()}');
      throw const MainException();
    }
  }

  Future<void> _createNotification(CustomNotification notification) async {
    final notificationRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(notification.receiverId);
    await notificationRef
        .collection('notifications')
        .doc(notification.notificationId)
        .set(notification.toMap());
  }
}
