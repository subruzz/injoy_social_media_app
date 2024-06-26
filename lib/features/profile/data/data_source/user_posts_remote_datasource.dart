import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/post_model.dart';

abstract class UserPostsRemoteDataSource {
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByUser(String userId);
}

class UserPostsRemoteDatasourceImpl implements UserPostsRemoteDataSource {
  @override
  Future<({List<PostModel> userPosts, List<String> userPostImages})>
      getAllPostsByUser(String userId) async {
    try {
      final posts = await FirebaseFirestore.instance
          .collection('posts')
          .where("creatorUid", isEqualTo: userId)
          .orderBy('createAt', descending: true)
          .get();
      List<String> postImages = [];
      final userAllPosts = posts.docs.map((posts) {
        if (posts['postImageUrl'] != null &&
            posts['postImageUrl'] is List) {
          final currentPostImages = List<String>.from(posts['postImageUrl']);
          postImages.addAll(currentPostImages);
        }
        return PostModel.fromJson(
          posts.data(),
        );
      }).toList();
      return (userPosts: userAllPosts, userPostImages: postImages);
    } catch (e) {
      print('error is this ${e.toString()}');
      throw const MainException(errorMsg: 'Error while loading the posts!');
    }
  }
}
