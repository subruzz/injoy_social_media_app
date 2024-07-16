import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';

abstract class PostFeedRemoteDatasource {
  Future<List<PostModel>> fetchFollowedPosts(String userId);
  Future<List<PostModel>> fetchSuggestedPosts(AppUser user);
}

class PostFeedRemoteDatasourceImpl implements PostFeedRemoteDatasource {
  @override
  Future<List<PostModel>> fetchFollowedPosts(String userId) async {
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
      return result;
    } catch (e) {
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }

// Function to calculate distance between two GeoPoints (in kilometers)
  double calculateDistance(
      double? lat1, double? lon1, double? lat2, double? lon2) {
    if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
      return double.infinity; // Return a large value if any coordinate is null
    }

    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Future<List<PostModel>> fetchSuggestedPosts(AppUser user) async {
    final postCollection = FirebaseFirestore.instance.collection('posts');

    try {
      List<dynamic> interests = user.interests;
      double? userLat = user.latitude;
      double? userLon = user.longitude;

      // Define a list to hold the futures for the queries
      List<Future<QuerySnapshot>> queryFutures = [];

      // Query for posts by latitude and longitude if user location is provided
      if (userLat != null && userLon != null) {
        double latRange = 50 / 111; // Roughly 50km in latitude degrees
        double lonRange =
            50 / (111 * cos(userLat * (pi / 180))); // Adjusted for longitude

        Query latitudeQuery = postCollection
            .where('latitude', isGreaterThanOrEqualTo: userLat - latRange)
            .where('latitude', isLessThanOrEqualTo: userLat + latRange)
            .where('longitude', isGreaterThanOrEqualTo: userLon - lonRange)
            .where('longitude', isLessThanOrEqualTo: userLon + lonRange);

        queryFutures.add(latitudeQuery.get());
      }

      // Query for posts by interests
      if (interests.isNotEmpty) {
        Query hashtagQuery =
            postCollection.where('hashtags', arrayContainsAny: interests);

        queryFutures.add(hashtagQuery.get());
      }

      // Execute the queries in parallel and wait for all results
      List<QuerySnapshot> queryResults = await Future.wait(queryFutures);

      // Combine and deduplicate the results
      Map<String, PostModel> uniquePosts = {};
      for (var querySnapshot in queryResults) {
        for (var doc in querySnapshot.docs) {
          uniquePosts[doc.id] =
              PostModel.fromJson(doc.data() as Map<String, dynamic>);
        }
      }

      // Convert the map values to a list
      List<PostModel> suggestedPosts = uniquePosts.values.toList();

      return suggestedPosts;
    } catch (e) {
      throw const MainException();
    }
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
