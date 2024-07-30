import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/explore/data/model/explore_seearch_location_model.dart';

import '../../../../core/const/app_msg/app_error_msg.dart';

abstract interface class ExploreAppDatasource {
  Future<List<PartialUser>> searchUsers(String query);
  Future<List<HashtagModel>> searchHashTags(String query);
  Future<List<PostModel>> getRecommended(String query);
  Future<List<SearchLocationModel>> searchLocationInExplore(String query);
  Future<List<PostModel>> getTopPostsOfLocation(String location);
  Future<List<PostModel>> searchRecentPostsOfLocation(String location);
  Future<List<PostModel>> getTopPostsOfHashTags(String tag);
  Future<List<PostModel>> searchRecentPostsOfHashTags(String tag);
  Future<List<PartialUser>> getSuggestedUsers(
      List<String> interests, String myId);
  Future<List<PartialUser>> getNearByUsers(
      double latitude, double longitude, String myId);
}

class ExploreAppDatasourceImpl implements ExploreAppDatasource {
  final FirebaseFirestore _firebaseFirestore;

  ExploreAppDatasourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
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

  @override
  Future<List<PostModel>> getTopPostsOfLocation(String location) async {
    try {
      final locationRef = _firebaseFirestore
          .collection('locations')
          .doc(location)
          .collection('postIds');
      final querySnapshot = await locationRef.get();

      final List<String> postIds =
          querySnapshot.docs.map((doc) => doc.id).toList();

      final allPosts = await _firebaseFirestore
          .collection('posts')
          .where(FieldPath.documentId, whereIn: postIds)
          .orderBy('likesCount', descending: true)
          .orderBy('totalComments', descending: true)
          .get();

      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      for (var post in allPosts.docs) {
        final userDoc = await userRef.doc(post['creatorUid']).get();
        if (!userDoc.exists) continue;
        final PartialUser user =
            PartialUser.fromJson(userDoc as Map<String, dynamic>);
        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }

      // final List<PostModel> posts = postsQuery.docs.map((doc) {
      //   final data = doc.data();
      //   return PostModel.fromJson(data,null);
      // }).toList();

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> searchRecentPostsOfLocation(String location) async {
    try {
      final locationRef = _firebaseFirestore
          .collection('locations')
          .doc(location)
          .collection('postIds');
      final querySnapshot = await locationRef.get();

      final List<String> postIds =
          querySnapshot.docs.map((doc) => doc.id).toList();

      final allPosts = await _firebaseFirestore
          .collection('posts')
          .where(FieldPath.documentId, whereIn: postIds)
          .orderBy('createAt', descending: true)
          .orderBy('totalComments', descending: true)
          .get();
      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      for (var post in allPosts.docs) {
        final userDoc = await userRef.doc(post['creatorUid']).get();
        if (!userDoc.exists) continue;
        final PartialUser user =
            PartialUser.fromJson(userDoc as Map<String, dynamic>);
        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }
      // final List<PostModel> posts = postsQuery.docs.map((doc) {
      //   final data = doc.data();
      //   return PostModel.fromJson(data, null);
      // }).toList();

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> getTopPostsOfHashTags(String tag) async {
    try {
      final allPosts = await _firebaseFirestore
          .collection('posts')
          .where('hashtags', arrayContains: tag)
          .get();
      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      for (var post in allPosts.docs) {
        final userDoc = await userRef.doc(post['creatorUid']).get();
        if (!userDoc.exists) continue;
        final PartialUser user =
            PartialUser.fromJson(userDoc as Map<String, dynamic>);
        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }
      // final List<PostModel> posts = querySnapshot.docs.map((doc) {
      //   final data = doc.data();
      //   return PostModel.fromJson(data, null);
      // }).toList();

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PostModel>> searchRecentPostsOfHashTags(String tag) async {
    try {
      // Calculate the timestamp for 24 hours ago
      final DateTime twentyFourHoursAgo =
          DateTime.now().subtract(const Duration(hours: 24));

      final allPosts = await _firebaseFirestore
          .collection('posts')
          .where('hashtags', arrayContains: tag)
          .where('createAt', isGreaterThanOrEqualTo: twentyFourHoursAgo)
          .orderBy('createAt', descending: true)
          .get();
      List<PostModel> posts = [];
      final userRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      for (var post in allPosts.docs) {
        final userDoc = await userRef.doc(post['creatorUid']).get();
        if (!userDoc.exists) continue;
        final PartialUser user =
            PartialUser.fromJson(userDoc as Map<String, dynamic>);
        final currentPost = PostModel.fromJson(post.data(), user);
        posts.add(currentPost);
      }
      // final List<PostModel> posts = querySnapshot.docs.map((doc) {
      //   final data = doc.data();
      //   return PostModel.fromJson(data, null);
      // }).toList();

      return posts;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PartialUser>> getSuggestedUsers(
      List<String> interests, String myId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('users')
          .where('id', isNotEqualTo: myId)
          .where('interests', arrayContainsAny: interests)
          .limit(2)
          .get();
      final List<PartialUser> suggestedUsers = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return PartialUser.fromJson(data);
      }).toList();
      return suggestedUsers;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<PartialUser>> getNearByUsers(
      double latitude, double longitude, String myId) async {
    try {
      double latRange = 50 / 111; // Roughly 50km in latitude degrees
      double lonRange =
          50 / (111 * cos(latitude * (pi / 180))); // Adjusted for longitude
      final querySnapshot = await _firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .where('id', isNotEqualTo: myId)
          .where('latitude', isGreaterThanOrEqualTo: latitude - latRange)
          .where('latitude', isLessThanOrEqualTo: latitude + latRange)
          .where('longitude', isGreaterThanOrEqualTo: longitude - lonRange)
          .where('longitude', isLessThanOrEqualTo: longitude + lonRange)
          .get();
      final List<PartialUser> nearByPeople = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return PartialUser.fromJson(data);
      }).toList();

      return nearByPeople;
    } catch (e) {
      throw const MainException();
    }
  }
}
