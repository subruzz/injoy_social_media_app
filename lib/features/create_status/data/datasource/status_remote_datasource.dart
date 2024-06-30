import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/create_status/data/models/status_model.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';
import 'package:uuid/uuid.dart';

abstract interface class StatusRemoteDatasource {
  Future<void> createStatus(
      StatusEntity status, SingleStatusEntity singleStatus);
  Future<void> updateStatus(StatusEntity status);
  Future<void> updateOnlyImageStatus(StatusEntity status);
  Future<void> seenStatusUpdate(int index, String userId, String viewedUserId);
  Future<void> deleteStatus(String statusId, String uId);
  Stream<List<StatusEntity>> getStatuses(String uid);
  Stream<StatusModel?> getMyStatus(String uid);
  Future<List<StatusEntity>> getMyStatusFuture(String uid);
  Future<void> createMultipleStatus(
      StatusEntity status, List<String> caption, List<AssetEntity> assets);
  Future<List<Map<String, String>>> uploadStatusImages(
      List<AssetEntity> postImages, String pId);
}

class StatusRemoteDatasourceImpl implements StatusRemoteDatasource {
  @override
  Future<void> createStatus(
      StatusEntity status, SingleStatusEntity singleStatus) async {
    final allStatusCollection =
        FirebaseFirestore.instance.collection('allStatus');

    try {
      final userRef = await allStatusCollection.doc(status.uId).get();
      if (!userRef.exists) {
        final newStatus = StatusModel(
            uId: status.uId,
            profilePic: status.profilePic,
            userName: status.userName,
            lastCreated: status.lastCreated,
            statuses: status.statuses);
        await allStatusCollection.doc(status.uId).set(newStatus.toMap());
      } else {
        final List<dynamic> allStatusesData = userRef['statuses'];

        allStatusesData.add(singleStatus.toJson());
        await allStatusCollection
            .doc(status.uId)
            .update({'statuses': allStatusesData});
      }
    } catch (e) {
      print(e.toString());
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<void> createMultipleStatus(StatusEntity status, List<String> caption,
      List<AssetEntity> assets) async {
    try {
      final allStatusCollection =
          FirebaseFirestore.instance.collection('allStatus');
      final images = await uploadStatusImages(assets, status.uId);
      List<SingleStatusEntity> newStatuses = [];
      final currentTime = Timestamp.now();
      for (int i = 0; i < images.length; i++) {
        final newStatus = SingleStatusEntity(
            statusImage: images[i]['downloadUrl']!,
            content: caption[i].isEmpty ? null : caption[i],
            statusId: images[i]['imageId']!,
            timestamp: currentTime,
            viewers: []);
        newStatuses.add(newStatus);
      }
      final userRef = await allStatusCollection.doc(status.uId).get();
      if (!userRef.exists) {
        final newStatus = StatusModel(
            uId: status.uId,
            profilePic: status.profilePic,
            userName: status.userName,
            lastCreated: status.lastCreated,
            statuses: newStatuses);
        await allStatusCollection.doc(status.uId).set(newStatus.toMap());
      } else {
        final List<dynamic> allStatusesData = userRef['statuses'];

        allStatusesData.addAll(newStatuses);
        await allStatusCollection
            .doc(status.uId)
            .update({'statuses': allStatusesData});
      }
    } catch (e) {
      print(e.toString());
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<void> deleteStatus(String statusId, String uId) async {
    try {
      final allStatusCollection =
          FirebaseFirestore.instance.collection('allStatus').doc(uId);
      allStatusCollection.collection('statuses').doc(statusId).delete();
    } catch (e) {
      throw const MainException(errorMsg: 'Error while deleting this status!');
    }
  }

  @override
  Stream<StatusModel?> getMyStatus(String uid) {
    final myStatusCollection = FirebaseFirestore.instance
        .collection('allStatus')
        .where('uId', isEqualTo: uid)
        .limit(1);

    return myStatusCollection.snapshots().map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      print('dlisteinging hnew vlaue cming bro');
      return StatusModel.fromMap(querySnapshot.docs.first.data());
    }).handleError((error) {
      print('Error fetching status: ${error.toString()}');
      throw MainException(errorMsg: 'Error fetching status: $error');
    });
  }

  @override
  Stream<List<StatusEntity>> getStatuses(String uid) async* {
    try {
      final currentUserDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final List<dynamic> followings =
          currentUserDoc.data()?['following'] ?? [];

      if (followings.isEmpty) {
        yield [];
      }
      // final List<String> followings = ['hZ84imarGjWH7fI9GjlvdHgblYz2'];

      final statusCollection = FirebaseFirestore.instance
          .collection('allStatus')
          .orderBy('lastCreated', descending: true)
          .where('uId', whereIn: followings);

      yield* statusCollection.snapshots().map((docSnapShot) {
        return docSnapShot.docs
            .where((doc) => doc.data()['statuses'].isNotEmpty)
            .map((e) => StatusModel.fromMap(e.data()))
            .toList();
      });
    } catch (e) {
      print('error ${e.toString()}');
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<List<StatusEntity>> getMyStatusFuture(String uid) {
    // TODO: implement getMyStatusFuture
    throw UnimplementedError();
  }

  @override
  Future<void> seenStatusUpdate(
      int index, String userId, String viewedUserId) async {
    try {
      final allStatusCollection =
          FirebaseFirestore.instance.collection('allStatus').doc(userId);
      final statusDoc = await allStatusCollection.get();
      final statuses =
          List<Map<String, dynamic>>.from(statusDoc.get('statuses'));
      final viewersList = List<String>.from(statuses[index]['viewers']);
      print(
          'this is the fucking thisn ${(List<String>.from(statuses[index]['viewers']))}');
      if (!viewersList.contains(viewedUserId)) {
        viewersList.add(viewedUserId);
        statuses[index]['viewers'] = viewersList;
        await allStatusCollection.update({'statuses': statuses});
      }
    } catch (e) {
      throw const MainException(errorMsg: 'unexpected error');
    }
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

  @override
  Future<List<Map<String, String>>> uploadStatusImages(
      List<AssetEntity> postImages, String uId) async {
    try {
      if (postImages.isEmpty) {
        return [];
      }

      final FirebaseStorage storage = FirebaseStorage.instance;
      List<Map<String, String>> postImageUrls = [];
      Reference ref = storage.ref().child('statusImages').child(uId);

      for (var image in postImages) {
        File? file = await image.file;
        if (file == null) continue;

        String imageId = const Uuid().v4();
        UploadTask task = ref.child(imageId).putFile(file);
        TaskSnapshot snapshot = await task;

        String downloadUrl = await snapshot.ref.getDownloadURL();
        postImageUrls.add({
          'imageId': imageId,
          'downloadUrl': downloadUrl,
        });
      }

      return postImageUrls;
    } catch (e) {
      throw MainException(errorMsg: 'Error while uploading status images: $e');
    }
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
