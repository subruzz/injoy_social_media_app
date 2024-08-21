import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_field_const.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_storage_const.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/core/services/firebase/firebase_storage.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

abstract interface class StatusRemoteDatasource {
  Future<void> createStatus(SingleStatusEntity singleStatus);
  Future<void> seenStatusUpdate(String statusId, String viewedUserId);
  Future<void> deleteStatus(String statusId, String? imgUrl);
  Future<void> createMultipleStatus(
      List<SingleStatusEntity> statuses, List<SelectedByte> assets);
  Future<List<Map<String, String>>> uploadStatusImages(
      List<SelectedByte> postImages, String pId);
}

class StatusRemoteDatasourceImpl implements StatusRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  StatusRemoteDatasourceImpl(
      {required this.firestore, required this.firebaseStorage});

  @override
  Future<void> createStatus(SingleStatusEntity singleStatus) async {
    final statusCollection =
        firestore.collection(FirebaseCollectionConst.statuses);
    try {
      //creating the statuses in the status collection
      await statusCollection
          .doc(singleStatus.statusId)
          .set(singleStatus.toJson());
      // await FirebaseFirestore.instance.runTransaction((transaction) async {
      //   final userRef = allStatusCollection.doc(status.uId);
      //   final userDoc = await transaction.get(userRef);
      //   final singleStatusRef = statusCollection.doc(singleStatus.statusId);

      //   // Add the single status
      //   transaction.set(singleStatusRef, singleStatus.toJson());

      //   if (!userDoc.exists) {
      //     // Create a new user document with the status ID
      //     transaction.set(userRef, {
      //       'uId': status.uId,
      //       'lastCreated': status.lastCreated,
      //       'statusIds': [singleStatus.statusId],
      //     });
      //   } else {
      //     // Update the existing user document to add the new status ID
      //     transaction.update(userRef, {
      //       'statusIds': FieldValue.arrayUnion([singleStatus.statusId]),
      //       'lastCreated': status.lastCreated, // Optionally update lastCreated
      //     });
      //   }
      // });
    } catch (e) {
      throw MainException(details: e.toString());
    }
  }

  @override
  Future<void> createMultipleStatus(
      List<SingleStatusEntity> statuses, List<SelectedByte> assets) async {
    try {
      final statusCollection =
          firestore.collection(FirebaseCollectionConst.statuses);

      // Uploading all images in the list and obtaining their download URLs.
      // The images are returned in a map because we need a unique ID for each status.
      // By creating the ID here, we can reference the images of this status.
      // The map will return the status image ID, which will be assigned as the status ID.
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw const MainException();
      }

      // Using batched writes for efficiency
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < assets.length; i++) {
        final res = await serviceLocator<FirebaseStorageService>()
            .uploadSingleAsset(
                asset: assets[i].selectedFile!,
                reference:
                    '${FirebaseFirestoreConst.statusImages}/$uid/${FirebaseFirestoreConst.statusImages}');
        if (res == null) continue;
        statuses[i] = statuses[i].copyWith(statusImage: res);
        batch.set(
            statusCollection.doc(statuses[i].statusId), statuses[i].toJson());
      }
      // Iterating over each uploaded image and creating new single status entity
      // for (int i = 0; i < images.length; i++) {
      //   final newStatus = SingleStatusEntity(
      //       uId: status.uId,
      //       statusImage: images[i]['downloadUrl']!, //image url from the map
      //       content: captions[i].isEmpty ? null : captions[i],
      //       statusId: images[i][
      //           'imageId']!, //image id from the map to use it for statusid as well
      //       createdAt: currentTime,
      //       viewers: {});

      //   // Add set operation to the batch
      //   batch.set(statusCollection.doc(newStatus.statusId), newStatus.toJson());
      // }

      // Commit the batch
      await batch.commit();
    } catch (e) {
      log('erroe adding multiple status ${e.toString()}');
      throw MainException(details: e.toString());
    }
  }

  @override
  Future<void> deleteStatus(String statusId, String? imgUrl) async {
    try {
      //deleting the status using the status id
      final statusRef =
          firestore.collection(FirebaseCollectionConst.statuses).doc(statusId);
      if (imgUrl != null) {
        Reference imageRef = firebaseStorage.refFromURL(imgUrl);
        await imageRef.delete();
      }
      await statusRef.delete();
    } catch (e) {
      throw MainException(
          errorMsg: AppErrorMessages.statusDeleteFailed, details: e.toString());
    }
  }

  @override
  Future<void> seenStatusUpdate(String statusId, String viewedUserId) async {
    try {
      final statusRef =
          firestore.collection(FirebaseCollectionConst.statuses).doc(statusId);

      // Fetch the current viewers map
      final statusDoc = await statusRef.get();
      final viewersMap =
          statusDoc.data()?['viewers'] as Map<String, dynamic>? ?? {};

      // Get the current timestamp
      final currentTimestamp = FieldValue.serverTimestamp();

      // Update the viewers map with the new timestamp for the viewed user
      viewersMap[viewedUserId] = currentTimestamp;

      // Write the updated viewers map back to Firestore
      await statusRef.update({
        FirebaseFieldConst.viewersListOfStatuses: viewersMap,
      });
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<Map<String, String>>> uploadStatusImages(
      List<SelectedByte> postImages, String uId) async {
    try {
      //if not status images is picked return empty list
      if (postImages.isEmpty) {
        return [];
      }
      // List to store maps of image IDs and their download URLs
      List<Map<String, String>> postImageUrls = [];
      // Reference to the Firebase Storage location for status images under user's ID
      Reference ref = firebaseStorage
          .ref()
          .child(FirebaseFirestoreConst.statusImages)
          .child(uId);

      // for (var image in postImages) {
      //   //get the  file from the AssetEntity

      //   // Compress the image; resulting type will be Uint8List
      //   final data = await testComporessList(image.selectedByte);
      //   //generating unique id
      //   String imageId = IdGenerator.generateUniqueId();
      //   // Upload the compressed image data to Firebase Storage
      //   UploadTask task = ref.child(imageId).putData(data);
      //   TaskSnapshot snapshot = await task;

      //   String downloadUrl = await snapshot.ref.getDownloadURL();
      //   //add the  image id with its download url to list
      //   postImageUrls.add({
      //     'imageId': imageId,
      //     'downloadUrl': downloadUrl,
      //   });
      // }

      return postImageUrls;
    } catch (e) {
      throw Exception();
    }
  }
}
