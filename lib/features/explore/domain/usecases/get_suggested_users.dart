// import 'package:fpdart/fpdart.dart';
// import 'package:social_media_app/core/common/models/partial_user_model.dart';
// import 'package:social_media_app/core/errors/failure.dart';
// import 'package:social_media_app/core/common/usecases/usecase.dart';
// import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

// class GetSuggestedUsersUseCase
//     implements UseCase<List<PartialUser>, GetSuggestedUsersUseCaseParams> {
//   final ExploreAppRepository _exploreAppRepository;

//   GetSuggestedUsersUseCase({required ExploreAppRepository exploreAppRepository})
//       : _exploreAppRepository = exploreAppRepository;

//   @override
//   Future<Either<Failure, List<PartialUser>>> call(
//       GetSuggestedUsersUseCaseParams params) async {
//     return await _exploreAppRepository.getSuggestedUsers(
//         params.interests, params.myId);
//   }
// }

// class GetSuggestedUsersUseCaseParams {
//   final String myId;
//   final List<String> interests;

//   GetSuggestedUsersUseCaseParams({required this.myId, required this.interests});
// }
