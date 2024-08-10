import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/exception.dart';

import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/common/models/post_model.dart';

abstract interface class ReelsDataSource {
  Future<List<PostEntity>> getRandomReels(String myId);
}

class ReelsDataSourceImpl implements ReelsDataSource {
  final FirebaseFirestore firestore;

  ReelsDataSourceImpl({required this.firestore});

  @override
  Future<List<PostEntity>> getRandomReels(String myId) async {
    List<PostEntity> reels = [];

    try {
      // Fetch a batch of reels
      final QuerySnapshot<Map<String, dynamic>> reelsQuerySnapshot =
          await firestore
              .collection('reels')
              .orderBy('createAt',
                  descending: true) // Assuming you have a createdAt field
              .limit(10) // Adjust the limit as needed
              .get();

      // Iterate through each reel and fetch associated user details
      for (var reelDoc in reelsQuerySnapshot.docs) {
        final String creatorUid = reelDoc['creatorUid'];

        // Fetch the user document associated with the reel
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firestore.collection('users').doc(creatorUid).get();

        if (userDoc.exists) {
          // Convert user document to PartialUser entity
          final PartialUser user = PartialUser.fromJson(userDoc.data()!);

          // Convert reel document to PostEntity (or PostModel) including user details
          final PostEntity reel = PostModel.fromJson(reelDoc.data(), user);

          // Add the reel to the list
          reels.add(reel);
        }
      }

      // Shuffle the reels to randomize the order
      reels.shuffle(Random());

      return reels;
    } catch (e) {
      // Handle errors
      throw const MainException();
    }
  }
}
