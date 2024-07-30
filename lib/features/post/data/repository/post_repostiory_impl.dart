// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';

import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/post/data/datasources/remote/post_remote_datasource.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';

class PostRepostioryImpl implements PostRepository {
  final PostRemoteDatasource _postRemoteDatasource;
  PostRepostioryImpl(
    this._postRemoteDatasource,
  );

  @override
  Future<Either<Failure, Unit>> createPost(
      PostEntity post, List<SelectedByte> postImage) async {
    try {
      await _postRemoteDatasource.createPost(post, postImage);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    try {
      await _postRemoteDatasource.deletePost(postId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts(String uid) {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query) async {
    try {
      final result = await _postRemoteDatasource.searchHashTags(query);
      return right(result);
    } on MainException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(
    UpdatePostEntity post,
    String postId,
  ) async {
    try {
      await _postRemoteDatasource.updatePost(post, postId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> likePost(
      String postId, String currentUserUid) async {
    try {
      await _postRemoteDatasource.likePost(postId, currentUserUid);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> unLikePost(
      String postId, String currentUserUid) async {
    try {
      await _postRemoteDatasource.unLikePost(postId, currentUserUid);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
