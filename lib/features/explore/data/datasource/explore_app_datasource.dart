import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/common/models/hashtag_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/explore/data/model/explore_seearch_location_model.dart';

abstract interface class ExploreAppDatasource {
  Future<List<AppUserModel>> searchUsers(String query);
  Future<List<HashtagModel>> searchHashTags(String query);
  Future<List<PostModel>> getRecommended(String query);
  Future<List<SearchLocationModel>> searchLocationInExplore(String query);
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
  Future<List<AppUserModel>> searchUsers(String query) async {
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
          .map((doc) => AppUserModel.fromJson(doc.data()))
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
      final descriptionSnapshot = await postsCollection
          .where('description', isGreaterThanOrEqualTo: normalizedQuery)
          .where('description', isLessThanOrEqualTo: '$normalizedQuery\uf8ff')
          .get(); // Query for partial matches in locationName
      final locationSnapshot = await postsCollection
          .where('locationName', isGreaterThanOrEqualTo: normalizedQuery)
          .where('locationName', isLessThanOrEqualTo: '$normalizedQuery\uf8ff')
          .get(); // Query for exact matches in hashtags array
      final hashtagSnapshot = await postsCollection
          .where('hashtags', arrayContains: normalizedQuery)
          .get(); // Combine results and remove duplicates
      final combinedResults = [
        ...descriptionSnapshot.docs,
        ...locationSnapshot.docs,
        ...hashtagSnapshot.docs,
      ];
      final uniqueResults = combinedResults
          .fold<Map<String, DocumentSnapshot>>({}, (map, doc) {
            map[doc.id] = doc;
            return map;
          })
          .values
          .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return uniqueResults;
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<List<SearchLocationModel>> searchLocationInExplore(String query) async {
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
}
