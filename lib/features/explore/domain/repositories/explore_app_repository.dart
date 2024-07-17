import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

abstract interface class ExploreAppRepository {
  //search for specific thing
  Future<Either<Failure, List<PartialUser>>> searchUsers(String query);
  Future<Either<Failure, List<HashTag>>> searchHashTags(String query);
  Future<Either<Failure, List<PostEntity>>> getRecommended(String query);
  Future<Either<Failure, List<ExploreLocationSearchEntity>>>
      searchLocationInExplore(String query);
  Future<Either<Failure, List<PartialUser>>> getSuggestedUsers(
      List<String> interests, String myId);
  Future<Either<Failure, List<PartialUser>>> getNearyByUsers(
      double latitude, double longitude, String myId);
  //posts based on location
  Future<Either<Failure, List<PostEntity>>> getTopPostsOfLocation(
      String location);
  Future<Either<Failure, List<PostEntity>>> searchRecentPostsOfLocation(
      String location);
  //posts based on tags
  Future<Either<Failure, List<PostEntity>>> getTopPostsOfHashTags(String tag);
  Future<Either<Failure, List<PostEntity>>> searchRecentPostsOfHashTags(
      String tag);
}
