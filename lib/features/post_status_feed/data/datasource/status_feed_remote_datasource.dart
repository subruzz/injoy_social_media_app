import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_field_const.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/utils/cut_off_time.dart';
import 'package:social_media_app/features/status/data/models/status_model.dart';

abstract interface class StatusFeedRemoteDatasource {
  Stream<List<StatusEntity>> getStatuses(String uid);
  Stream<List<SingleStatusEntity>> getMyStatus(String uid);
}

class StatusFeedRemoteDatasourceimpl implements StatusFeedRemoteDatasource {
  final FirebaseFirestore firestore;
  // map for caching the user
  // this is used when retreving the all status of user followers
  // we will cache it once we got a user and use it when fetching again for efficiency
  //*This map has a type of string and record
  //*Record feature is introduced in Dart 3.0
  final Map<String, ({String name, String? profilePic})> _userCache = {};
  StatusFeedRemoteDatasourceimpl({required FirebaseFirestore firebasefirestore})
      : firestore = firebasefirestore;
  @override
  Stream<List<SingleStatusEntity>> getMyStatus(String uid) {
    final statusCollection =
        firestore.collection(FirebaseCollectionConst.statuses);
    try {
      //*24 hour cut off time to fetch only status from last 24 hours;
      final cutoffTimestamp = cutOffTime;
      log('this called');

      ///returning the list of statuses of current user from status collection using
      ///the user id
      final statuses = statusCollection
          .where(FirebaseFieldConst.uId, isEqualTo: uid)
          .where(FirebaseFieldConst.createdAt, isGreaterThan: cutoffTimestamp)
          .orderBy(FirebaseFieldConst.createdAt, descending: true);
      return statuses.snapshots().map((status) => status.docs
          .map((doc) => SingleStatusEntity.fromJson(doc.data()))
          .toList());
    } catch (e) {
      throw MainException(
          errorMsg: AppErrorMessages.myStatusFetchFailed,
          details: e.toString());
    }
  }

  Future<({String name, String? profilePic})> _getUserDetails(
      String userId) async {
    ///checking in the map if user is already there or not
    ///if user is there we immediately return the userdetails
    if (_userCache.containsKey(userId)) {
      return _userCache[userId]!;
    } else {
      ///if cached map doesnt have the user  fetch it from
      ///the firebase and add to the map
      ///so next time this user details wont be fetched and return immediately
      final userDoc = await FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.users)
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data()!;
        ({String name, String? profilePic}) record =
            (name: data['userName'], profilePic: data['profilePic']);
        _userCache[userId] = record;
        return _userCache[userId]!;
      } else {
        throw Exception("User not found");
      }
    }
  }

  @override
  Stream<List<StatusModel>> getStatuses(String uid) async* {
    try {
      final cutoffTimestamp = cutOffTime;
      if (_userCache.isNotEmpty) {
        _userCache.clear();
      }

      //fetching the current user details to get the following of the user
      final currentUserDoc = await firestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .get();
      final List<dynamic> followings =
          currentUserDoc.data()?[FirebaseFieldConst.following] ?? [];
      // if no followers is there  yeild []
      if (followings.isEmpty) {
        yield [];
      } else {
        // Yield a stream of snapshots representing statuses from followed users
        final statusCollection = FirebaseFirestore.instance
            .collection(FirebaseCollectionConst.statuses)
            .where(FirebaseFieldConst.createdAt, isGreaterThan: cutoffTimestamp)
            .where(FirebaseFieldConst.uId, whereIn: followings)
            .orderBy(FirebaseFieldConst.createdAt, descending: true);

        yield* statusCollection.snapshots().asyncMap((querySnapshot) async {
          // Group statuses by userId
          Map<String, List<SingleStatusEntity>> userStatusesMap = {};
          for (var doc in querySnapshot.docs) {
            final singleStatus = SingleStatusEntity.fromJson(doc.data());
            if (!userStatusesMap.containsKey(singleStatus.uId)) {
              userStatusesMap[singleStatus.uId] = [];
            }
            userStatusesMap[singleStatus.uId]!.add(singleStatus);
          }

          // Fetch user details and construct StatusModel
          List<StatusModel> statusModels = [];
          for (var userId in userStatusesMap.keys) {
            final userData = await _getUserDetails(userId);

            statusModels.add(StatusModel(
              uId: userId,
              userName: userData.name,
              profilePic: userData.profilePic,
              lastCreated: userStatusesMap[userId]!.first.createdAt,
              statuses: userStatusesMap[userId]!,
            ));
          }
          return statusModels;
        });
      }
    } catch (e) {
      throw MainException(
          errorMsg: AppErrorMessages.statusFetchFailed, details: e.toString());
    }
  }
}
