import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

abstract interface class ExploreAppRepository {
  Future<Either<Failure, List<AppUser>>> searchUsers(String query);
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query);
  Future<Either<Failure, List<PostEntity>>> getRecommended(String query);
  Future<Either<Failure, List<ExploreLocationSearchEntity>>> searchLocationInExplore(
      String query);
}
