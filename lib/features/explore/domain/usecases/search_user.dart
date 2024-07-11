import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class SearchUserUseCase
    implements UseCase<List<AppUser>, SearchUserUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  SearchUserUseCase({required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<AppUser>>> call(
      SearchUserUseCaseParams params) async {
    return await _exploreAppRepository.searchUsers(params.query);
  }
}

class SearchUserUseCaseParams {
  final String query;

  SearchUserUseCaseParams({required this.query});
}
