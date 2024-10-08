import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_following_posts.dart';

abstract class PostFeedRemoteDatasource {
  Future<PostsResult> fetchFollowedPosts(String userId, List<String> following,
      {int limit = 4, DocumentSnapshot? lastDoc});
  Future<List<PostModel>> fetchSuggestedPosts(AppUser user);
  Future<List<PartialUser>> getAllUser(
      {required String id, required List<String> following});
}

class PostFeedRemoteDatasourceImpl implements PostFeedRemoteDatasource {
  final FirebaseFirestore _firestore;
  PostFeedRemoteDatasourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<PostsResult> fetchFollowedPosts(String userId, List<String> following,
      {int limit = 4, DocumentSnapshot? lastDoc}) async {
    if (following.isEmpty) {
      return PostsResult(posts: [], hasMore: false, lastDoc: null);
    }
    final postcollection = _firestore.collection(FirebaseCollectionConst.posts);
    try {
      // This pagination approach is not the most efficient because
      // we are increasing the limit incrementally (e.g., 10 -> 20 -> 30).
      // Each time, the query fetches from the beginning with the increased limit,
      // leading to redundant data being fetched on every load.
      // This method was implemented as a workaround because `startAfterDocument`
      // was not working with `where` queries in this specific context.

      Query<Map<String, dynamic>> postsQuery = postcollection
          .where('creatorUid', isNotEqualTo: userId)
          .where('creatorUid', whereIn: following)
          .where('isThatvdo', isEqualTo: false)
          .orderBy('createAt', descending: true);

      if (lastDoc != null) {
        // postsQuery = postsQuery.startAfterDocument(lastDoc);
      }

      //   postsQuery = postsQuery.startAfterDocument(lastDoc);
      // }
      List<PostModel> posts = [];
      final userRef = _firestore.collection(FirebaseCollectionConst.users);
      final QuerySnapshot<Map<String, dynamic>> allPosts =
          await postsQuery.get();
      for (var post in allPosts.docs) {
        final userDoc = await userRef.doc(post['creatorUid']).get();
        if (!userDoc.exists) continue;
        final PartialUser user = PartialUser.fromJson(userDoc.data()!);
        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }

      // final List<PostModel> result = allPosts.docs.map((doc) {
      //   return PostModel.fromJson(
      //     doc.data(),
      //   );
      // }).toList();
      // log('res is ${result.length}');
      final hasMore = posts.length == limit;

      return PostsResult(
        posts: posts,
        hasMore: hasMore,
        lastDoc: allPosts.docs.isNotEmpty ? allPosts.docs.last : null,
      );
    } catch (e) {
      throw const MainException(errorMsg: AppErrorMessages.postFetchError);
    }
  }

  double calculateDistance(
      double? lat1, double? lon1, double? lat2, double? lon2) {
    if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
      return double.infinity; // Return a large value if any coordinate is null
    }

    const p = 0.017453292519943295;
    final a = 0.5 -
        math.cos((lat2 - lat1) * p) / 2 +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - lon1) * p)) /
            2;
    return 12742 * math.asin(math.sqrt(a));
  }

  @override
  Future<List<PostModel>> fetchSuggestedPosts(AppUser user) async {
    final postCollection = _firestore.collection('posts');

    return [];
    //   List<Future<QuerySnapshot>> queryFutures = [];

    //   if (userLat != null && userLon != null) {
    //     double latRange = 50 / 111; // Roughly 50km in latitude degrees
    //     double lonRange = 50 /
    //         (111 *
    //             math.cos(userLat * (math.pi / 180))); // Adjusted for longitude

    //     Query latitudeQuery = postCollection
    //         .where('latitude', isGreaterThanOrEqualTo: userLat - latRange)
    //         .where('latitude', isLessThanOrEqualTo: userLat + latRange)
    //         .where('longitude', isGreaterThanOrEqualTo: userLon - lonRange)
    //         .where('longitude', isLessThanOrEqualTo: userLon + lonRange);

    //     queryFutures.add(latitudeQuery.get());
    //   }

    //   if (interests.isNotEmpty) {
    //     Query hashtagQuery =
    //         postCollection.where('hashtags', arrayContainsAny: interests);

    //     queryFutures.add(hashtagQuery.get());
    //   }

    //   List<QuerySnapshot> queryResults = await Future.wait(queryFutures);

    //   Map<String, PostModel> uniquePosts = {};
    //   for (var querySnapshot in queryResults) {
    //     for (var doc in querySnapshot.docs) {
    //       // Fetch user details for each post
    //       final userDoc =
    //           await _firestore.collection('users').doc(doc['creatorUid']).get();
    //       if (!userDoc.exists) continue;

    //       final PartialUser postUser = PartialUser.fromJson(userDoc.data()!);
    //       final currentPost =
    //           PostModel.fromJson(doc.data() as Map<String, dynamic>, postUser);
    //       uniquePosts[doc.id] = currentPost;
    //     }
    //   }

    //   List<PostModel> suggestedPosts = uniquePosts.values.toList();

    //   return suggestedPosts;
    // } catch (e) {
    //   // Log or handle the error as needed
    //   throw const MainException(
    //       errorMsg: AppErrorMessages.forYouPostFetchError);
    // }
  }

  @override
  Future<List<PartialUser>> getAllUser(
      {required String id, required List<String> following}) async {
    try {
      final allUsersQuery = _firestore
          .collection(FirebaseCollectionConst.users)
          .where('id', isNotEqualTo: id)
          .get();

// Wait for the query to complete
      final queryResults = await allUsersQuery;
      final List<QueryDocumentSnapshot> docs = queryResults.docs;

// Create a set to track unique users and prevent duplicates
      final Set<String> userIds = {};
      final List<PartialUser> allUsers = [];

      for (var doc in docs) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data == null) continue;
        final id = data['id'];
        if (id == null || following.contains(id)) continue;

        final PartialUser user = PartialUser.fromJson(data);
        if (userIds.add(user.id)) {
          allUsers.add(user);
        }
      }

      return allUsers;
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
