import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/features/create_status/data/models/status_model.dart';

abstract class PostFeedRemoteDatasource {
  Future<List<PostModel>> fetchFollowedPosts(String userId);
  Future<List<PostModel>> fetchSuggestedPosts(String userId);
  Future<List<StatusModel>> fetchStatus(String userId);
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
      print('error is this ${e.toString()}');
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }

  @override
  Future<List<PostModel>> fetchSuggestedPosts(String userId) {
    // TODO: implement fetchSuggestedPosts
    throw UnimplementedError();
  }

  @override
  Future<List<StatusModel>> fetchStatus(String userId) async {
    try {
      // Fetch current user's following data
      // final userDoc = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .get();

      // final List<String>? followingData =
      //     userDoc.data()?['followings'] as List<String>?;

      // // Initialize list for user's following statuses
      // List<StatusModel> userFollowingStatuses = [];

      // if (followingData != null && followingData.isNotEmpty) {
      //   // Fetch statuses from users the current user is following
      //   final statusQuery = await FirebaseFirestore.instance
      //       .collection('status')
      //       .where('userId', whereIn: followingData)
      //       .orderBy('timestamp', descending: true)
      //       .get();

      //   userFollowingStatuses = statusQuery.docs
      //       .map((doc) => StatusModel.fromMap(doc.data()))
      //       .toList();
      // }

      // Fetch current user's own statuses
      final currentStatusesSnapshot = await FirebaseFirestore.instance
          .collection('status')
          .where("userId", isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      final List<StatusModel> userStatuses = currentStatusesSnapshot.docs
          .map((doc) => StatusModel.fromMap(doc.data()))
          .toList();
      return userStatuses;

      // return (
      //   userStatus: userStatuses,
      //   userFollowingStatus: userFollowingStatuses,
      // );
    } catch (e) {
      print('Error: ${e.toString()}');
      throw MainException(errorMsg: 'Error while loading statuses!');
    }
  }
}
