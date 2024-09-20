// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/repository/user_dat_repository.dart';

class GetMyLikedPostsUseCase
    implements UseCase<List<PostEntity>, GetMyLikedPostsUseCaseParams> {
  final UserDatRepository _userPostRepository;

  GetMyLikedPostsUseCase({required UserDatRepository userPostRepository})
      : _userPostRepository = userPostRepository;
  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetMyLikedPostsUseCaseParams params) async {
    return await _userPostRepository.getMyLikedPosts(params.uid);
  }
}

class GetMyLikedPostsUseCaseParams {
  final String uid;
  GetMyLikedPostsUseCaseParams({
    required this.uid,
  });
}
