import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/create_status/data/models/status_model.dart';
import 'package:social_media_app/features/create_status/domain/entities/status_user_entity.dart';

abstract interface class StatusRemoteDatasource {
  Future<void> createStatus(StatusEntity status);
  Future<void> updateStatus(StatusEntity status);
  Future<void> updateOnlyImageStatus(StatusEntity status);
  Future<void> seenStatusUpdate(String statusId, int imageIndex, String userId);
  Future<void> deleteStatus(StatusEntity status);
  Stream<List<StatusEntity>> getStatuses(StatusEntity status);
  Stream<List<StatusEntity>> getMyStatus(String uid);
  Future<List<StatusEntity>> getMyStatusFuture(String uid);
}

class StatusRemoteDatasourceImpl implements StatusRemoteDatasource {
  @override
  Future<void> createStatus(StatusEntity status) async {
    final allStatusCollection =
        FirebaseFirestore.instance.collection('allStatus');
    final newStatus = StatusModel(
        sId: status.sId,
        uId: status.uId,
        profilePic: status.profilePic,
        userName: status.userName,
        lastCreated: status.lastCreated,
        statuses: status.statuses);
    try {
      final userRef = await allStatusCollection.doc(status.uId).get();
      if(userRef.exists){
        final 
      }
    } catch (e) {}
  }

  @override
  Future<void> deleteStatus(StatusEntity status) {
    // TODO: implement deleteStatus
    throw UnimplementedError();
  }

  @override
  Stream<List<StatusEntity>> getMyStatus(String uid) {
    // TODO: implement getMyStatus
    throw UnimplementedError();
  }

  @override
  Future<List<StatusEntity>> getMyStatusFuture(String uid) {
    // TODO: implement getMyStatusFuture
    throw UnimplementedError();
  }

  @override
  Stream<List<StatusEntity>> getStatuses(StatusEntity status) {
    // TODO: implement getStatuses
    throw UnimplementedError();
  }

  @override
  Future<void> seenStatusUpdate(
      String statusId, int imageIndex, String userId) {
    // TODO: implement seenStatusUpdate
    throw UnimplementedError();
  }

  @override
  Future<void> updateOnlyImageStatus(StatusEntity status) {
    // TODO: implement updateOnlyImageStatus
    throw UnimplementedError();
  }

  @override
  Future<void> updateStatus(StatusEntity status) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }
  // @override
  // Future<void> createStatus(StatusEntity status,
  //     StatusUserAttribute statusUserAttributes, File? statusImg) async {
  //   final allStatusCollection =
  //       FirebaseFirestore.instance.collection('allStatus');

  //   try {
  //     final currentUserStatus =
  //         allStatusCollection.doc(statusUserAttributes.uid);
  //     final userStatus = await currentUserStatus.get();
  //     if (userStatus.exists) {
  //       await currentUserStatus
  //           .update({'lastCreated': statusUserAttributes.lastCreated});
  //     } else {
  //       await currentUserStatus.set(statusUserAttributes.toJson());
  //     }
  //     await currentUserStatus
  //         .collection('statuses')
  //         .doc(status.sId)
  //         .set(status.toJson());
  //   } catch (e) {
  //     throw MainException(
  //         errorMsg: 'Error creating post', details: e.toString());
  //   }
  // }

  // @override
  // Future<void> seenStatusUpdate(
  //     String statusId, String userId, int index) async {
  //   // try {
  //   //   final allStatusCollection =
  //   //       FirebaseFirestore.instance.collection('allStatus');
  //   //   final statusDoc = await allStatusCollection
  //   //       .doc(userId)
  //   //       .collection('statuses')
  //   //       .doc(statusId)
  //   //       .get();
  //   //       final List<String>  viewersList=List<String>.from()
  //   // } catch (e) {
  //   //   throw MainException(
  //   //       errorMsg: 'Unexpected error occured', details: e.toString());
  //   // }
  // }

  // @override
  // Future<void> deleteStatus(StatusEntity status) {
  //   // TODO: implement deleteStatus
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> updateStatus(StatusEntity status, File? statusImg) {
  //   // TODO: implement updateStatus
  //   throw UnimplementedError();
  // }

  // @override
  // Future<String> uploadUserImage(File? statusImg, String sId) {
  //   // TODO: implement uploadUserImage
  //   throw UnimplementedError();
  // }
}
