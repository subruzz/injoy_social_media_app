import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/features/create_post/domain/enitities/post.dart';

abstract interface class PostRepository {
  Future<Either<Failure, Unit>> createPost(
      PostEntity post, List<File?> postImage);
  Future<Either<Failure, List<PostEntity>>> getAllPosts(String uid);
  Future<Either<Failure, Unit>> updatePost(
      PostEntity post, List<File?> postImage);
  Future<Either<Failure, Unit>> deletePost(PostEntity post);
  Future<Either<Failure, Unit>> likePost(PostEntity post);
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query);
}
