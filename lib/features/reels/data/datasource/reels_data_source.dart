import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';

import '../../../../core/utils/di/di.dart';

abstract class ReelsDataSource {
  Future<GetReelsResponse> getRandomReels(
      String? excludedId, String myId, DocumentSnapshot? lastDocument);
}

class ReelsDataSourceImpl implements ReelsDataSource {
  final FirebaseFirestore firestore;

  ReelsDataSourceImpl({required this.firestore});

  @override
  Future<GetReelsResponse> getRandomReels(
      String? excludedId, String myId, DocumentSnapshot? lastDocument) async {
    try {
      final shorts = await serviceLocator<FirebaseHelper>().getAllPostsOrShorts(
          uId: myId, isShorts: true, excludeId: excludedId);
      return GetReelsResponse(reels: shorts);
    } catch (e) {
      log('Exception in reel pagination: ${e.toString()}');
      throw const MainException();
    }
  }
}

class GetReelsResponse {
  final List<PostEntity> reels;
  final DocumentSnapshot? lastDocument;

  GetReelsResponse({required this.reels, this.lastDocument});
}
