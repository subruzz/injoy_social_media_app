import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';

import '../../../../settings/domain/entity/ui_entity/enums.dart';

abstract interface class NotificationDatasource {
  Future<void> createNotification(
      {required CustomNotification notification,
      required NotificationPreferenceEnum notificationPreferenceType});
  Future<void> deleteNotification(
      {required NotificationCheck notificationCheck});
  Stream<List<CustomNotification>> getMyNotifications({required String myId});
  Future<void> deleteOneNotificationDirectly(
      {required String notificationId, required String myId});
}

class NotificationDatasourceImple implements NotificationDatasource {
  final FirebaseFirestore _firebaseFirestore;

  NotificationDatasourceImple({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> createNotification(
      {required CustomNotification notification,
      required NotificationPreferenceEnum notificationPreferenceType}) async {
    try {
      log('called');
      AppUserModel user = await getUserInfo(notification.receiverId);
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
            user: null, deviceToken: token, notification: notification);
        await _createNotification(notification);
      }
    } catch (e) {
      log('error is this from the notification${e.toString()}');
      throw const MainException();
    }
  }

  Future<void> _createNotification(CustomNotification notification) async {
    final notificationRef = _firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(notification.receiverId);
    await notificationRef
        .collection('notifications')
        .doc(notification.notificationId)
        .set(notification.toMap());
  }

  Future<AppUserModel> getUserInfo(dynamic userId) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firebaseFirestore.collection('users').doc(userId).get();
    if (snap.exists) {
      return AppUserModel.fromJson(snap.data()!);
    } else {
      throw const MainException();
    }
  }

  @override
  Future<void> deleteNotification(
      {required NotificationCheck notificationCheck}) async {
    final notificationRef = _firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(notificationCheck.receiverId)
        .collection('notifications');
    QuerySnapshot<Map<String, dynamic>> getDoc;

    if (notificationCheck.notificationType == NotificationType.post &&
        notificationCheck.isThatLike) {
      getDoc = await notificationRef
          .where("isThatLike", isEqualTo: notificationCheck.isThatLike)
          .where("isThatPost", isEqualTo: notificationCheck.isThatPost)
          .where("senderId", isEqualTo: notificationCheck.senderId)
          .where("uniqueId", isEqualTo: notificationCheck.uniqueId)
          .get();
      for (final doc in getDoc.docs) {
        notificationRef.doc(doc.id).delete();
      }
    } else if (notificationCheck.notificationType == NotificationType.profile) {
      log('camer here');
      getDoc = await notificationRef
          .where("senderId", isEqualTo: notificationCheck.senderId)
          .where("uniqueId", isEqualTo: notificationCheck.uniqueId)
          .get();
      for (final doc in getDoc.docs) {
        notificationRef.doc(doc.id).delete();
      }
    } else if (notificationCheck.notificationType == NotificationType.post &&
        !notificationCheck.isThatLike) {
      getDoc = await notificationRef
          .where("isThatLike", isEqualTo: notificationCheck.isThatLike)
          .where("isThatPost", isEqualTo: notificationCheck.isThatPost)
          .where("senderId", isEqualTo: notificationCheck.senderId)
          .where("uniqueId", isEqualTo: notificationCheck.uniqueId)
          .where('postId', isEqualTo: notificationCheck.postId)
          .get();
      for (final doc in getDoc.docs) {
        notificationRef.doc(doc.id).delete();
      }
    }
  }

  @override
  Stream<List<CustomNotification>> getMyNotifications({required String myId}) {
    log('this stream called');
    final notificationRef = _firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(myId)
        .collection('notifications')
        .orderBy('time', descending: true);
    log('my id is $myId');

    return notificationRef.snapshots().asyncMap((snapshot) async {
      final notifications = await Future.wait(snapshot.docs.map((doc) async {
        final notificationData = doc.data();
        CustomNotification customNotification =
            CustomNotification.fromJson(notificationData);

        // Fetch the partial user details using the userId from the notification
        final partialUser = await serviceLocator<FirebaseHelper>()
            .getUserPartialDetails(customNotification.senderId);

        customNotification = customNotification.copyWith(
            senderName: partialUser?.userName,
            personalProfileImageUrl: partialUser?.profilePic);
        // Add the PartialUser data to the CustomNotification
        return customNotification;
      }).toList());

      return notifications;
    });
  }

  @override
  Future<void> deleteOneNotificationDirectly(
      {required String notificationId, required String myId}) async {
    final notificationRef = _firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(myId)
        .collection('notifications');
    await notificationRef.doc(notificationId).delete();
  }
}
