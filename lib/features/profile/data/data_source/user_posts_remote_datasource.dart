import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/create_post/data/models/post_model.dart';

abstract class UserPostsRemoteDataSource {
  Future<List<PostModel>> getAllPostsByUser(String userId);
}

class UserPostsRemoteDatasourceImpl implements UserPostsRemoteDataSource {
  @override
  Future<List<PostModel>> getAllPostsByUser(String userId) async {
    try {
      final posts = await FirebaseFirestore.instance
          .collection('posts')
          .where("creatorUid", isEqualTo: userId)
          .orderBy('createAt', descending: true)
          .get();
      final userPosts = posts.docs
          .map(
            (posts) => PostModel.fromJson(
              posts.data(),
            ),
          )
          .toList();
      return userPosts;
    } catch (e) {
      print('error is this ${e.toString()}');
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }
}
