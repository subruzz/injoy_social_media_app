import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

abstract interface class ExploreAppRepository {
  //search for specific thing
  Future<Either<Failure, List<PartialUser>>> searchUsers(String query);
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query);
  Future<Either<Failure, List<PostEntity>>> getRecommended(String query);
  Future<Either<Failure, List<ExploreLocationSearchEntity>>>
      searchLocationInExplore(String query);

  Future<Either<Failure, List<PostEntity>>> getPostSuggestionFromPost(
    PostEntity post,
    String myId,
  );
  Future<Either<Failure, List<PostEntity>>> getAllPosts(String id);
  Future<Either<Failure, List<PostEntity>>> getPostsOfHashTagsOrLocation(
      String tagOrLocation, bool isLoc);
  Future<Either<Failure, List<PostEntity>>> getShortsOfTagOrLocation(
      String tagOrLocation, bool isLoc);
}
