import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/explore/data/datasource/explore_app_datasource.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';
import '../../../post/domain/enitities/hash_tag.dart';

class ExploreAppRepoImpl implements ExploreAppRepository {
  final ExploreAppDatasource _exploreAppDatasource;

  ExploreAppRepoImpl({required ExploreAppDatasource exploreAppDatasource})
      : _exploreAppDatasource = exploreAppDatasource;
  @override
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query) async {
    try {
      final res = await _exploreAppDatasource.searchHashTags(query);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PartialUser>>> searchUsers(String query) async {
    try {
      final res = await _exploreAppDatasource.searchUsers(query);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getRecommended(String query) async {
    try {
      final res = await _exploreAppDatasource.getRecommended(query);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<ExploreLocationSearchEntity>>>
      searchLocationInExplore(String query) async {
    try {
      final res = await _exploreAppDatasource.searchLocationInExplore(query);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPostsOfHashTagsOrLocation(
      String tagOrLocation, bool isLoc) async {
    try {
      final res = await _exploreAppDatasource.getPostsOfHashTagsOrLocation(
          tagOrLocation, isLoc);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getShortsOfTagOrLocation(
      String tagOrLocation, bool isLoc) async {
    try {
      final res = await _exploreAppDatasource.getShortsOfTagOrLocation(
          tagOrLocation, isLoc);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPostSuggestionFromPost(
    PostEntity post,
    String myId,
  ) async {
    try {
      final res =
          await _exploreAppDatasource.getPostSuggestionFromPost(post, myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts(String id) async {
    try {
      final res = await _exploreAppDatasource.getAllPosts(id);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
