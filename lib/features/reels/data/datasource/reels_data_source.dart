import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/exception.dart';

import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/common/models/post_model.dart';

abstract interface class ReelsDataSource {
  Future<List<PostEntity>> getRandomReels(String myId, DocumentSnapshot? lastDocument);
}

class ReelsDataSourceImpl implements ReelsDataSource {
  final FirebaseFirestore firestore;

  ReelsDataSourceImpl({required this.firestore});

  @override
  Future<List<PostEntity>> getRandomReels(String myId, DocumentSnapshot? lastDocument) async {
    List<PostEntity> reels = [];

    try {
      Query<Map<String, dynamic>> query = firestore
          .collection('reels')
          .orderBy('createAt', descending: true) // Assuming you have a createdAt field
          .limit(10); // Adjust the limit as needed

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final QuerySnapshot<Map<String, dynamic>> reelsQuerySnapshot = await query.get();

      for (var reelDoc in reelsQuerySnapshot.docs) {
        final String creatorUid = reelDoc['creatorUid'];

        final DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore.collection('users').doc(creatorUid).get();

        if (userDoc.exists) {
          final PartialUser user = PartialUser.fromJson(userDoc.data()!);
          final PostEntity reel = PostModel.fromJson(reelDoc.data(), user);
          reels.add(reel);
        }
      }

      reels.shuffle(Random());
      return reels;
    } catch (e) {
      throw const MainException();
    }
  }
}
