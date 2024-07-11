import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/explore/data/datasource/explore_app_datasource.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

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
  Future<Either<Failure, List<AppUser>>> searchUsers(String query) async {
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
  Future<Either<Failure, List<ExploreLocationSearchEntity>>> searchLocationInExplore(
      String query) async {
    try {
      final res = await _exploreAppDatasource.searchLocationInExplore(query);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
