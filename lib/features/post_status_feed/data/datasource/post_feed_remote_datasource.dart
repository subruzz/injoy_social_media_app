import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';

abstract class PostFeedRemoteDatasource {
  Future<List<PostModel>> fetchFollowedPosts(String userId);
  Future<List<PostModel>> fetchSuggestedPosts(String userId);
}

class PostFeedRemoteDatasourceImpl implements PostFeedRemoteDatasource {
  @override
  Future<List<PostModel>> fetchFollowedPosts(String userId) async {
    log('getting posts');
    try {
      final posts = await FirebaseFirestore.instance
          .collection('posts')
          .where("creatorUid", isNotEqualTo: userId)
          .orderBy('createAt', descending: true)
          .get();
      final List<PostModel> result = posts.docs
          .map(
            (doc) => PostModel.fromJson(
              doc.data(),
            ),
          )
          .toList();
      print(result);
      return result;
    } catch (e) {
      print('error is this ${e.toString()}');
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }

  @override
  Future<List<PostModel>> fetchSuggestedPosts(String userId) {
    // TODO: implement fetchSuggestedPosts
    throw UnimplementedError();
  }

  // @override
  // Future<StatusUserStatus> fetchCurrentUserStatus(String userId) async {
  //   try {
  //     // Fetch the user's profile information
  //     final userDocSnapshot = await FirebaseFirestore.instance
  //         .collection('allStatus')
  //         .doc(userId)
  //         .get();

  //     if (!userDocSnapshot.exists) {
  //       throw Exception('User not found');
  //     }

  //     final statusUserAttribute = StatusUserAttribute.fromJson(
  //         userDocSnapshot.data() as Map<String, dynamic>);
  //     // Fetch the user's statuses
  //     final statusesSnapshot = await FirebaseFirestore.instance
  //         .collection('allStatus')
  //         .doc(userId)
  //         .collection('statuses')
  //         .orderBy('timestamp', descending: true)
  //         .get();

  //     final List<StatusModel> userStatuses = statusesSnapshot.docs
  //         .map((doc) => StatusModel.fromMap(doc.data()))
  //         .toList();

  //     return StatusUserStatus(
  //       statusUserAttribute: statusUserAttribute,
  //       userStatus: userStatuses,
  //     );
  //   } catch (e) {
  //     print('Error: ${e.toString()}');
  //     throw const MainException(errorMsg: 'Error while loading statuses!');
  //   }
  // }

  // @override
  // Future<List<StatusUserStatus>> fetchCurrentUserAndFollowingStatuses(
  //     String currentUserId) async {
  //   try {
  //     // Fetch the current user's document to get the list of followed users
  //     final currentUserDocSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(currentUserId)
  //         .get();

  //     if (!currentUserDocSnapshot.exists) {
  //       throw Exception('Current user not found');
  //     }

  //     // Extract the list of followed user IDs
  //     final List<dynamic> following =
  //         currentUserDocSnapshot.data()?['following'] ?? [];

  //     // Initialize a list to hold all the followed users' statuses
  //     List<StatusUserStatus> allStatuses = [];

  //     // Fetch the statuses of each followed user
  //     for (String userId in following) {
  //       final userDocSnapshot = await FirebaseFirestore.instance
  //           .collection('allStatus')
  //           .doc(userId)
  //           .get();

  //       if (!userDocSnapshot.exists) {
  //         continue;
  //       }

  //       final userStatusUserAttribute = StatusUserAttribute.fromJson(
  //           userDocSnapshot.data() as Map<String, dynamic>);

  //       final userStatusesSnapshot = await FirebaseFirestore.instance
  //           .collection('allStatus')
  //           .doc(userId)
  //           .collection('statuses')
  //           .orderBy('timestamp', descending: true)
  //           .get();

  //       final List<StatusModel> userStatuses = userStatusesSnapshot.docs
  //           .map((doc) =>
  //               StatusModel.fromMap(doc.data()))
  //           .toList();

  //       final model = StatusUserStatus(
  //         statusUserAttribute: userStatusUserAttribute,
  //         userStatus: userStatuses,
  //       );

  //       allStatuses.add(model);
  //     }

  //     return allStatuses;
  //   } catch (e) {
  //     print('Error fetching statuses: $e');
  //     rethrow;
  //   }
  // }
}
