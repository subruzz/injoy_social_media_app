import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetSuggestedPostsFromPostUseCase
    implements UseCase<List<PostEntity>, GetSuggestedPostsFromPostUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetSuggestedPostsFromPostUseCase({required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetSuggestedPostsFromPostUseCaseParams params) async {
    return await _exploreAppRepository.getPostSuggestionFromPost(
        params.post, params.myId);
  }
}

class GetSuggestedPostsFromPostUseCaseParams {
  final String myId;
  final PostEntity post;

  GetSuggestedPostsFromPostUseCaseParams({required this.myId, required this.post});
}
