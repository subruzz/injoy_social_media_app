import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/exception.dart';

import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/common/models/post_model.dart';

abstract class ReelsDataSource {
  Future<GetReelsResponse> getRandomReels(
      String myId, DocumentSnapshot? lastDocument);
}

class ReelsDataSourceImpl implements ReelsDataSource {
  final FirebaseFirestore firestore;

  ReelsDataSourceImpl({required this.firestore});

  @override
  Future<GetReelsResponse> getRandomReels(
      String myId, DocumentSnapshot? lastDocument) async {
    List<PostEntity> reels = [];
    log('Last document in data source: $lastDocument');

    try {
      QuerySnapshot<Map<String, dynamic>> reelsQuerySnapshot;
      reelsQuerySnapshot = await firestore
          .collection('posts')
          // .where('creatorUid', isEqualTo: myId)
          .orderBy('createAt', descending: true)
          .where('isThatvdo', isEqualTo: true)
          .limit(2)
          .get();

      if (lastDocument != null) {
        reelsQuerySnapshot = await firestore
            .collection('reels')
            .orderBy('createAt', descending: true)
            .limit(2)
            .startAfterDocument(lastDocument)
            .get();

        // log('Applying pagination with last document: ${lastDocument.id}');
        // query = query.startAfterDocument(lastDocument);
      }

      log('Fetched ${reelsQuerySnapshot.docs.length} documents');

      for (var reelDoc in reelsQuerySnapshot.docs) {
        final String creatorUid = reelDoc['creatorUid'];
        log('Fetching user document for UID: $creatorUid');

        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firestore.collection('users').doc(creatorUid).get();

        if (userDoc.exists) {
          final PartialUser user = PartialUser.fromJson(userDoc.data()!);
          final PostEntity reel = PostModel.fromJson(reelDoc.data(), user);
          reels.add(reel);
        } else {
          log('User document not found for UID: $creatorUid');
        }
      }

      final DocumentSnapshot? newLastDocument =
          reelsQuerySnapshot.docs.isNotEmpty
              ? reelsQuerySnapshot.docs.last
              : null;
      log('New last document: ${newLastDocument?.id}');
      reels.shuffle();
      return GetReelsResponse(reels: reels, lastDocument: newLastDocument);
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
