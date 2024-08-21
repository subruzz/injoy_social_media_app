import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';

import '../../../../core/common/models/partial_user_model.dart';

abstract interface class PostRepository {
  Future<Either<Failure, Unit>> createPost(
      PostEntity post,
      List<SelectedByte> postImage,
      List<Uint8List>? postImgesFromWeb,
      bool isReel);
  Future<Either<Failure, List<PostEntity>>> getAllPosts(String uid);
  Future<Either<Failure, PostEntity>> updatePost(
    UpdatePostEntity post,
    PartialUser postUser,
    String postId,
  );
  Future<Either<Failure, Unit>> deletePost(String postId, bool isReel);
  Future<Either<Failure, Unit>> likePost(
      String postId, String currentUserUid, bool isReel);
  Future<Either<Failure, Unit>> unLikePost(
      String postId, String currentUserUid, bool isReel);
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query);
  Future<Either<Failure, Unit>> savePosts(String postId);
}
