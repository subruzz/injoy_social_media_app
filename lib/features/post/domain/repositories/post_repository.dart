
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';

abstract interface class PostRepository {
  Future<Either<Failure, Unit>> createPost(
      PostEntity post, List<SelectedByte> postImage);
  Future<Either<Failure, List<PostEntity>>> getAllPosts(String uid);
  Future<Either<Failure, PostEntity>> updatePost(
    UpdatePostEntity post,
    String postId,
  );
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, Unit>> likePost(String postId, String currentUserUid);
  Future<Either<Failure, Unit>> unLikePost(
      String postId, String currentUserUid);
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query);
}
