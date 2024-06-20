import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/create_status/data/models/status_model.dart';

abstract interface class StatusRemoteDatasource {
  Future<void> createStatus(StatusEntity status, File? statusImg);
  Future<void> updateStatus(StatusEntity status, File? statusImg);
  Future<void> deleteStatus(StatusEntity status);
  Future<String> uploadUserImage(File? statusImg, String sId);
}

class StatusRemoteDatasourceImpl implements StatusRemoteDatasource {
  @override
  Future<void> createStatus(StatusEntity status, File? statusImg) async {
    final postCollection = FirebaseFirestore.instance.collection('status');

    try {
      // final statusUrl = await uploadUserImage(statusImg, status.id);
      final newStatus = StatusModel(
          userName: status.userName,
          statusImage: null,
          sId: status.sId,
          userId: status.userId,
          content: status.content,
          timestamp: status.timestamp,
          color: status.color);
      await postCollection.doc(status.sId).set(newStatus.toMap());
    } catch (e) {
      throw MainException(
          errorMsg: 'Error creating post', details: e.toString());
    }
  }

  @override
  Future<void> deleteStatus(StatusEntity status) {
    // TODO: implement deleteStatus
    throw UnimplementedError();
  }

  @override
  Future<void> updateStatus(StatusEntity status, File? statusImg) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }

  @override
  Future<String> uploadUserImage(File? statusImg, String sId) {
    // TODO: implement uploadUserImage
    throw UnimplementedError();
  }
}
