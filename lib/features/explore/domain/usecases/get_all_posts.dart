import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetAllPostsUseCase
    implements UseCase<List<PostEntity>, GetAllPostsUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetAllPostsUseCase({required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetAllPostsUseCaseParams params) async {
    return await _exploreAppRepository.getAllPosts(params.id);
  }
}

class GetAllPostsUseCaseParams {
  final String id;

  GetAllPostsUseCaseParams({required this.id});
}
