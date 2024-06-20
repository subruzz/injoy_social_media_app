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
}
