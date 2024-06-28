// import 'package:fpdart/src/either.dart';
// import 'package:social_media_app/core/common/entities/status_entity.dart';
// import 'package:social_media_app/core/errors/failure.dart';
// import 'package:social_media_app/core/usecases/usecase.dart';
// import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';
// import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';

// class ViewCurrentUserStatusUseCase
//     implements UseCase<StatusUserStatus, ViewCurrentUserStatusUseCaseParams> {
//   @override
//   final PostFeedRepository _postFeedRepository;

//   ViewCurrentUserStatusUseCase({required PostFeedRepository postFeedRepository})
//       : _postFeedRepository = postFeedRepository;
//   @override
//   Future<Either<Failure, StatusUserStatus>> call(params) async {
//     return await _postFeedRepository.fetchCurrentUserStatus(params.uid);
//   }
// }

// class ViewCurrentUserStatusUseCaseParams {
//   final String uid;

//   ViewCurrentUserStatusUseCaseParams({required this.uid});
// }
