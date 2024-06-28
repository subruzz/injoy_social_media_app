import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

abstract interface class StatusRemoteDatasource {
  Future<void> createStatus(
      StatusEntity status, SingleStatusEntity singleStatus);
  Future<void> updateStatus(StatusEntity status);
  Future<void> updateOnlyImageStatus(StatusEntity status);
  Future<void> seenStatusUpdate(
      String statusId, String userId, String viewedUserId);
  Future<void> deleteStatus(String statusId, String uId);
  Stream<List<AllStatusEntity>> getStatuses(String uid);
  Stream<AllStatusEntity> getMyStatus(String uid);
  Future<List<StatusEntity>> getMyStatusFuture(String uid);
}

class StatusRemoteDatasourceImpl implements StatusRemoteDatasource {
  @override
  Future<void> createStatus(
      StatusEntity status, SingleStatusEntity singleStatus) async {
    final allStatusCollection =
        FirebaseFirestore.instance.collection('allStatus');

    try {
      final currentUserStatus = allStatusCollection.doc(status.uId);
      final userStatusRef = await currentUserStatus.get();
      if (userStatusRef.exists) {
        await currentUserStatus.update({'lastCreated': status.lastCreated});
      } else {
        await currentUserStatus.set(status.toMap());
      }
      await currentUserStatus
          .collection('statuses')
          .doc(singleStatus.statusId)
          .set(singleStatus.toJson());
    } catch (e) {
      throw MainException(
          errorMsg: 'Error creating post', details: e.toString());
    }
    // try {
    //   final userRef = await allStatusCollection.doc(status.uId).get();
    //   if (!userRef.exists) {
    //     final newStatus = StatusModel(
    //         uId: status.uId,
    //         profilePic: status.profilePic,
    //         userName: status.userName,
    //         lastCreated: status.lastCreated,
    //        );
    //     await allStatusCollection.doc(status.uId).set(newStatus.toJson());
    //   } else {
    //     final List<dynamic> allStatusesData = userRef['statuses'];

    //     allStatusesData.add(singleStatus.toJson());
    //     await allStatusCollection
    //         .doc(status.uId)
    //         .update({'statuses': allStatusesData});
    //   }
    // } catch (e) {
    //   print(e.toString());
    //   throw MainException(errorMsg: e.toString());
    // }
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
  Stream<AllStatusEntity> getMyStatus(String uid) async* {
    try {
      final userDocument =
          FirebaseFirestore.instance.collection('allStatus').doc(uid);

      // Stream for listening to changes in the user document
      final userDocStream =
          userDocument.snapshots().asyncMap((docSnapshot) async {
        print('myran ivde ethi');

        if (!docSnapshot.exists) {
          return null;
        }
        final statusUserEntity =
            StatusEntity.fromMap(docSnapshot.data() as Map<String, dynamic>);
        return statusUserEntity;
      });
      //listening to the allStatus collection
      await for (final statusUserEntity in userDocStream) {
        print('myran ivde ethiya');

        if (statusUserEntity == null) {
          continue;
        }

        // Stream for listening to changes in the statuses subcollection
        yield* userDocument
            .collection('statuses')
            .orderBy('timestamp', descending: false)
            .where('timestamp',
                isGreaterThan:
                    DateTime.now().subtract(const Duration(hours: 24)))
            .snapshots()
            .asyncMap((statusSnapshot) async {
          final allStatuses = statusSnapshot.docs.map((statusDoc) {
            return SingleStatusEntity.fromJson(statusDoc.data());
          }).toList();

          return AllStatusEntity(
            statusEntity: statusUserEntity,
            allStatuses: allStatuses,
          );
        });
      }
    } catch (e) {
      throw const MainException(errorMsg: 'An unexpected error occurred!');
    }
  }

  @override
  Stream<List<AllStatusEntity>> getStatuses(String uid) async* {
    try {
      final currentUserDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final List<dynamic> followings =
          currentUserDoc.data()?['following'] ?? [];

      if (followings.isEmpty) {
        yield [];
        return;
      }

      List<AllStatusEntity> allFollowingStatuses = [];

      for (var follow in followings) {
        final userDocument =
            FirebaseFirestore.instance.collection('allStatus').doc(follow);
        final userData = await userDocument.get();

        if (!userData.exists) continue;

        final statusUserEntity =
            StatusEntity.fromMap(userData.data() as Map<String, dynamic>);

        final statusStream = userDocument
            .collection('statuses')
            .orderBy('timestamp', descending: false)
            .where("timestamp",
                isGreaterThan:
                    DateTime.now().subtract(const Duration(hours: 24)))
            .snapshots()
            .asyncMap((statusSnapshot) async {
          final allStatuses = statusSnapshot.docs.map((statusDoc) {
            return SingleStatusEntity.fromJson(statusDoc.data());
          }).toList();

          return AllStatusEntity(
            statusEntity: statusUserEntity,
            allStatuses: allStatuses,
          );
        });

        await for (var statusData in statusStream) {
          allFollowingStatuses.add(statusData);
          yield allFollowingStatuses;
        }
      }
    } catch (e) {
      yield [];
      rethrow;
    }
  }

  @override
  Future<List<StatusEntity>> getMyStatusFuture(String uid) {
    // TODO: implement getMyStatusFuture
    throw UnimplementedError();
  }

  @override
  Future<void> seenStatusUpdate(
      String statusId, String userId, String viewedUserId) async {
    try {
      final allStatusCollection =
          FirebaseFirestore.instance.collection('allStatus').doc(userId);
      final statusDoc =
          await allStatusCollection.collection('statuses').doc(statusId).get();
      final viewersList = List<String>.from(statusDoc.get('viewers'));
      if (!viewersList.contains(viewedUserId)) {
        viewersList.add(viewedUserId);
      }
      await allStatusCollection
          .collection('statuses')
          .doc(statusId)
          .update({'viewers': viewersList});
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
