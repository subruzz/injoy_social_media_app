import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/features/explore/data/model/explore_seearch_location_model.dart';

import '../../../../core/const/app_msg/app_error_msg.dart';

abstract interface class ExploreAppDatasource {
  Future<List<PartialUser>> searchUsers(String query);
  Future<List<HashtagModel>> searchHashTags(String query);
  Future<List<PostModel>> getRecommended(String query);
  Future<List<SearchLocationModel>> searchLocationInExplore(String query);

  Future<List<PostModel>> getPostsOfHashTagsOrLocation(
      String tagOrLocation, bool isLoc);
  Future<List<PostModel>> getShortsOfTagOrLocation(
      String tagOrLocation, bool isLoc);
  Future<List<PostModel>> getAllPosts(String id);
  Future<List<PostModel>> getPostSuggestionFromPost(
    PostEntity post,
    String myId,
  );
}

class ExploreAppDatasourceImpl implements ExploreAppDatasource {
  final FirebaseFirestore _firebaseFirestore;

  ExploreAppDatasourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<List<PostModel>> getAllPosts(
    String id,
  ) async {
    try {
      final postRef = _firebaseFirestore
          .collection(FirebaseCollectionConst.posts)
          .where('creatorUid', isNotEqualTo: id);

      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      // Cache map to store fetched user details
      final Map<String, PartialUser> userCache = {};
      final QuerySnapshot<Map<String, dynamic>> allPosts = await postRef.get();
      for (var post in allPosts.docs) {
        final creatorUid = post['creatorUid'] as String;

        // Check if the user details are already in the cache
        PartialUser? user = userCache[creatorUid];

        if (user == null) {
          // Fetch user details if not in the cache
          final userDoc = await userRef.doc(creatorUid).get();
          if (!userDoc.exists) continue;
          user = PartialUser.fromJson(userDoc.data()!);

          // Store the fetched user in the cache
          userCache[creatorUid] = user;
        }

        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<HashtagModel>> searchHashTags(String query) async {
    // ! Implement fullname searching as well(To do)
    try {
      final hashTagCollection =
          _firebaseFirestore.collection(FirebaseCollectionConst.hashTags);
      final querySnapshot = await hashTagCollection
          .where('hashtagName', isGreaterThanOrEqualTo: query)
          .where('hashtagName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Convert the query results to a list of AppUserModel
      final hashTags = querySnapshot.docs
          .map((doc) => HashtagModel.fromJson(doc.data()))
          .toList();
      return hashTags;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PartialUser>> searchUsers(String query) async {
    try {
      //search the user based on username from user collection
      final usersCollection =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);
      final querySnapshot = await usersCollection
          .where('userName', isGreaterThanOrEqualTo: query)
          .where('userName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Convert the query results to a list of AppUserModel
      final users = querySnapshot.docs
          .map((doc) => PartialUser.fromJson(doc.data()))
          .toList();
      return users;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> getRecommended(String query) async {
    try {
      final postsCollection =
          _firebaseFirestore.collection(FirebaseCollectionConst.posts);
      String normalizedQuery = query.toLowerCase().trim();

      // Query for partial matches in description
      final descriptionQuery = postsCollection
          .where('description', isGreaterThanOrEqualTo: normalizedQuery)
          .where('description', isLessThanOrEqualTo: '$normalizedQuery\uf8ff')
          .get();

      // Query for partial matches in locationName
      final locationQuery = postsCollection
          .where('location', isGreaterThanOrEqualTo: normalizedQuery)
          .where('location', isLessThanOrEqualTo: '$normalizedQuery\uf8ff')
          .get();

      // Query for exact matches in hashtags array
      final hashtagQuery = postsCollection
          .where('hashtags', arrayContains: normalizedQuery)
          .get();

      // Execute queries in parallel
      final results =
          await Future.wait([descriptionQuery, locationQuery, hashtagQuery]);

      // Combine results and remove duplicates
      final combinedResults =
          results.expand((snapshot) => snapshot.docs).toList();
      final uniqueResults = combinedResults
          .fold<Map<String, DocumentSnapshot>>({}, (map, doc) {
            map[doc.id] = doc;
            return map;
          })
          .values
          .toList();

      // Fetch user details and create PostModel instances
      final userCollection =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);
      final List<PostModel> recommendedPosts = [];

      for (var doc in uniqueResults) {
        final postData = doc.data() as Map<String, dynamic>;
        final creatorUid = postData['creatorUid'] as String;

        // Fetch user details for the creatorUid
        final userDoc = await userCollection.doc(creatorUid).get();
        if (!userDoc.exists) continue;
        final user = PartialUser.fromJson(userDoc.data()!);

        // Create PostModel with user details
        final post = PostModel.fromJson(postData, user);
        recommendedPosts.add(post);
      }

      return recommendedPosts;
    } catch (e) {
      // Improve error handling to provide more context
      throw const MainException(errorMsg: AppErrorMessages.postFetchError);
    }
  }

  @override
  Future<List<SearchLocationModel>> searchLocationInExplore(
      String query) async {
    try {
      final locationCollection =
          _firebaseFirestore.collection(FirebaseCollectionConst.locations);
      final querySnapshot = await locationCollection
          .where('locationName', isGreaterThanOrEqualTo: query)
          .where('locationName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Convert the query results to a list of AppUserModel
      final locations = querySnapshot.docs
          .map((doc) => SearchLocationModel.fromJson(doc.data()))
          .toList();
      return locations;
    } catch (e) {
      throw const MainException();
    }
  }

  // @override
  // Future<List<PostModel>> searchRecentPostsOfLocation(String location) async {
  //   try {
  //     final locationRef = _firebaseFirestore
  //         .collection('locations')
  //         .doc(location)
  //         .collection('postIds');
  //     final querySnapshot = await locationRef.get();

  //     final List<String> postIds =
  //         querySnapshot.docs.map((doc) => doc.id).toList();

  //     final allPosts = await _firebaseFirestore
  //         .collection('posts')
  //         .where(FieldPath.documentId, whereIn: postIds)
  //         .orderBy('createAt', descending: true)
  //         .orderBy('totalComments', descending: true)
  //         .get();
  //     List<PostModel> posts = [];
  //     final userRef =
  //         _firebaseFirestore.collection(FirebaseCollectionConst.users);

  //     for (var post in allPosts.docs) {
  //       final userDoc = await userRef.doc(post['creatorUid']).get();
  //       if (!userDoc.exists) continue;
  //       final PartialUser user =
  //           PartialUser.fromJson(userDoc as Map<String, dynamic>);
  //       final currentPost = PostModel.fromJson(post.data(), user);
  //       posts.add(currentPost);
  //     }
  //     // final List<PostModel> posts = postsQuery.docs.map((doc) {
  //     //   final data = doc.data();
  //     //   return PostModel.fromJson(data, null);
  //     // }).toList();

  //     return posts;
  //   } catch (e) {
  //     throw const MainException();
  //   }
  // }

  // @override
  // Future<List<PostModel>> getTopPostsOfLocation(String location) async {
  //   try {
  //     final allPosts = await _firebaseFirestore
  //         .collection('posts')
  //         .where('location', isEqualTo: location)
  //         .where('isThatvdo', isEqualTo: false)
  //         .get();

  //     List<PostModel> posts = [];
  //     final userRef =
  //         _firebaseFirestore.collection(FirebaseCollectionConst.users);

  //     // Cache map to store fetched user details
  //     final Map<String, PartialUser> userCache = {};

  //     for (var post in allPosts.docs) {
  //       final creatorUid = post['creatorUid'] as String;

  //       // Check if the user details are already in the cache
  //       PartialUser? user = userCache[creatorUid];

  //       if (user == null) {
  //         // Fetch user details if not in the cache
  //         final userDoc = await userRef.doc(creatorUid).get();
  //         if (!userDoc.exists) continue;
  //         user = PartialUser.fromJson(userDoc.data() as Map<String, dynamic>);

  //         // Store the fetched user in the cache
  //         userCache[creatorUid] = user;
  //       }

  //       final currentPost = PostModel.fromJson(post.data(), user);
  //       posts.add(currentPost);
  //     }

  //     return posts;
  //   } catch (e) {
  //     throw const MainException();
  //   }
  // }

  @override
  Future<List<PostModel>> getPostsOfHashTagsOrLocation(
      String tagOrLocation, bool isLoc) async {
    try {
      final allPosts = isLoc
          ? await _firebaseFirestore
              .collection('posts')
              .where('location', isEqualTo: tagOrLocation)
              .where('isThatvdo', isEqualTo: false)
              .get()
          : await _firebaseFirestore
              .collection('posts')
              .where('hashtags', arrayContains: tagOrLocation)
              .where('isThatvdo', isEqualTo: false)
              .get();

      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      // Cache map to store fetched user details
      final Map<String, PartialUser> userCache = {};

      for (var post in allPosts.docs) {
        final creatorUid = post['creatorUid'] as String;

        // Check if the user details are already in the cache
        PartialUser? user = userCache[creatorUid];

        if (user == null) {
          // Fetch user details if not in the cache
          final userDoc = await userRef.doc(creatorUid).get();
          if (!userDoc.exists) continue;
          user = PartialUser.fromJson(userDoc.data() as Map<String, dynamic>);

          // Store the fetched user in the cache
          userCache[creatorUid] = user;
        }

        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> getShortsOfTagOrLocation(
      String tagOrLocation, bool isLoc) async {
    try {
      final allPosts = isLoc
          ? await _firebaseFirestore
              .collection('posts')
              .where('location', isEqualTo: tagOrLocation)
              .where('isThatvdo', isEqualTo: true)
              .get()
          : await _firebaseFirestore
              .collection('posts')
              .where('hashtags', arrayContains: tagOrLocation)
              .where('isThatvdo', isEqualTo: true)
              .get();

      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      // Cache map to store fetched user details
      final Map<String, PartialUser> userCache = {};

      for (var post in allPosts.docs) {
        final creatorUid = post['creatorUid'] as String;

        // Check if the user details are already in the cache
        PartialUser? user = userCache[creatorUid];

        if (user == null) {
          // Fetch user details if not in the cache
          final userDoc = await userRef.doc(creatorUid).get();
          if (!userDoc.exists) continue;
          user = PartialUser.fromJson(userDoc.data() as Map<String, dynamic>);

          // Store the fetched user in the cache
          userCache[creatorUid] = user;
        }

        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  // @override
  // Future<List<PartialUser>> getSuggestedUsers(
  //     List<String> interests, String myId) async {
  //   try {
  //     final querySnapshot = await _firebaseFirestore
  //         .collection('users')
  //         .where('id', isNotEqualTo: myId)
  //         .where('interests', arrayContainsAny: interests)
  //         .get();
  //     final List<PartialUser> suggestedUsers = querySnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return PartialUser.fromJson(data);
  //     }).toList();
  //     return suggestedUsers;
  //   } catch (e) {
  //     throw const MainException();
  //   }
  // }

  // @override
  // Future<List<PartialUser>> getNearByUsers(
  //     double latitude, double longitude, String myId) async {
  //   try {
  //     double latRange = 50 / 111; // Roughly 50km in latitude degrees
  //     double lonRange =
  //         50 / (111 * cos(latitude * (pi / 180))); // Adjusted for longitude
  //     final querySnapshot = await _firebaseFirestore
  //         .collection(FirebaseCollectionConst.users)
  //         .where('id', isNotEqualTo: myId)
  //         .where('latitude', isGreaterThanOrEqualTo: latitude - latRange)
  //         .where('latitude', isLessThanOrEqualTo: latitude + latRange)
  //         .where('longitude', isGreaterThanOrEqualTo: longitude - lonRange)
  //         .where('longitude', isLessThanOrEqualTo: longitude + lonRange)
  //         .get();
  //     final List<PartialUser> nearByPeople = querySnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return PartialUser.fromJson(data);
  //     }).toList();

  //     return nearByPeople;
  //   } catch (e) {
  //     throw const MainException();
  //   }
  // }
  @override
  Future<List<PostModel>> getPostSuggestionFromPost(
    PostEntity post,
    String myId,
  ) async {
    try {
      Future<QuerySnapshot>? nearbyPostsQuery;
      Future<QuerySnapshot>? interestsQuery;

      if (post.latitude != null && post.longitude != null) {
        double latRange = 50 / 111;
        double lonRange = 50 / (111 * cos(post.latitude! * (pi / 180)));

        nearbyPostsQuery = _firebaseFirestore
            .collection(FirebaseCollectionConst.posts)
            .where('isThatvdo', isEqualTo: false)
            .where('creatorUid', isNotEqualTo: myId)
            .where('latitude',
                isGreaterThanOrEqualTo: post.latitude! - latRange)
            .where('latitude', isLessThanOrEqualTo: post.latitude! + latRange)
            .where('longitude',
                isGreaterThanOrEqualTo: post.longitude! - lonRange)
            .where('longitude', isLessThanOrEqualTo: post.longitude! + lonRange)
            .get();
      }

      if (post.hashtags.isNotEmpty) {
        interestsQuery = _firebaseFirestore
            .collection(FirebaseCollectionConst.posts)
            .where('isThatvdo', isEqualTo: false)
            .where('hashtags', arrayContainsAny: post.hashtags)
            .where('creatorUid', isNotEqualTo: myId)
            .get();
      }

      // Wait for both queries to complete
      final results = await Future.wait([
        if (interestsQuery != null) interestsQuery,
        if (nearbyPostsQuery != null) nearbyPostsQuery,
      ]);

      final List<QueryDocumentSnapshot> interestDocs =
          interestsQuery != null ? results[0].docs : [];
      final List<QueryDocumentSnapshot> nearbyDocs = nearbyPostsQuery != null
          ? (interestsQuery != null ? results[1].docs : results[0].docs)
          : [];

      // Create a set to track unique post IDs and prevent duplicates
      final Set<String> postIds = {};
      final List<PostModel> allPosts = [];

      // Reference to the users collection
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      // Cache map to store fetched user details
      final Map<String, PartialUser> userCache = {};

      // Helper function to process documents and add unique posts
      Future<void> processDocs(List<QueryDocumentSnapshot> docs) async {
        for (var doc in docs) {
          final data = doc.data() as Map<String, dynamic>?;
          if (data == null) continue;
          final id = data['postId'];
          if (id == post.postId || id == null || !postIds.add(id)) continue;

          final creatorUid = data['creatorUid'] as String;

          // Check if the user details are already in the cache
          PartialUser? user = userCache[creatorUid];

          if (user == null) {
            // Fetch user details if not in the cache
            final userDoc = await userRef.doc(creatorUid).get();
            if (!userDoc.exists) continue;
            user = PartialUser.fromJson(userDoc.data() as Map<String, dynamic>);

            // Store the fetched user in the cache
            userCache[creatorUid] = user;
          }

          // Create the PostModel with the user data
          final PostModel currentPost = PostModel.fromJson(data, user);
          allPosts.add(currentPost);
        }
      }

      // Process documents from both queries
      await processDocs(interestDocs);
      await processDocs(nearbyDocs);

      return allPosts;
    } catch (e) {
      throw const MainException();
    }
  }

//   @override
//   Future<List<PostModel>> getSuggestedPostBasedOnaPost(PostEntity post) async {
//     final myId = FirebaseAuth.instance.currentUser?.uid;
//     if (myId == null) {
//       throw const MainException();
//     }
//     double latRange = 0;
//     double lonRange = 0;
//     final Future<QuerySnapshot<Map<String, dynamic>>> postHashTagsQuery;
//     if (post.latitude != null) {
//       latRange = 50 / 111;
//       lonRange = 50 / (111 * cos(post.latitude! * (pi / 180)));
//       postHashTagsQuery = _firebaseFirestore
//           .collection(FirebaseCollectionConst.posts)
//           .where('creatorUid', isNotEqualTo: myId)
//           .where('hashtags', arrayContainsAny: post.hashtags)
//           .get();
//     }

//     final locationQuery = _firebaseFirestore
//         .collection(FirebaseCollectionConst.users)
//         .where('creatorUid', isNotEqualTo: myId)
//         .where('latitude', isGreaterThanOrEqualTo: post.latitude! - latRange)
//         .where('latitude', isLessThanOrEqualTo: post.latitude! + latRange)
//         .where('longitude', isGreaterThanOrEqualTo: post.longitude! - lonRange)
//         .where('longitude', isLessThanOrEqualTo: post.longitude! + lonRange)
//         .get();
//     final List<QuerySnapshot> queryResults =
//         await Future.wait([postHashTagsQuery, locationQuery]);
//     final List<QueryDocumentSnapshot> docs =
//         queryResults.expand((qs) => qs.docs).toList();
//   }

//   // final Set<String> userIds = {};
//   // final List<PartialUser> combinedUsers = [];

//   // for (var doc in docs) {
//   //   final data = doc.data() as Map<String, dynamic>?;

//   //   if (data == null) continue;
//   //   print('fwolling is $following');
//   //   final id = data['id'];
//   //   if (id == null || following.contains(id)) continue;

//   //   final PartialUser user = PartialUser.fromJson(data);
//   //   if (userIds.add(user.id)) {
//   //     combinedUsers.add(user);
//   //   }
//   // }
}
 // Define latitude and longitude ranges for proximity search
      // double latRange = 50 / 111; // Roughly 50km in latitude degrees
      // double lonRange =
      //     50 / (111 * cos(latitude * (pi / 180))); // Adjusted for longitude

      // // Create a query to fetch users by interests
      // final interestsQuery = _firebaseFirestore
      //     .collection(FirebaseCollectionConst.users)
      //     .where('id', isNotEqualTo: myId)
      //     .where('interests', arrayContainsAny: interests)
      //     .get();

      // // Create a query to fetch users by proximity
      // final locationQuery = _firebaseFirestore
      //     .collection(FirebaseCollectionConst.users)
      //     .where('id', isNotEqualTo: myId)
      //     .where('latitude', isGreaterThanOrEqualTo: latitude - latRange)
      //     .where('latitude', isLessThanOrEqualTo: latitude + latRange)
      //     .where('longitude', isGreaterThanOrEqualTo: longitude - lonRange)
      //     .where('longitude', isLessThanOrEqualTo: longitude + lonRange)
      //     .get();

      // // Wait for both queries to complete
      // final List<QuerySnapshot> queryResults =
      //     await Future.wait([interestsQuery, locationQuery]);
      // final List<QueryDocumentSnapshot> docs =
      //     queryResults.expand((qs) => qs.docs).toList();

      // // Create a set to track unique users and prevent duplicates
      // final Set<String> userIds = {};
      // final List<PartialUser> combinedUsers = [];

      // for (var doc in docs) {
      //   final data = doc.data() as Map<String, dynamic>?;

      //   if (data == null) continue;
      //   print('fwolling is $following');
      //   final id = data['id'];
      //   if (id == null || following.contains(id)) continue;

      //   final PartialUser user = PartialUser.fromJson(data);
      //   if (userIds.add(user.id)) {
      //     combinedUsers.add(user);
      //   }
      // }