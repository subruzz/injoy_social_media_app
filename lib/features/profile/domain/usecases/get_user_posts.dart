// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/repository/user_posts_repository.dart';

class GetUserPostsUseCase
    implements
        UseCase<({List<PostEntity> userPosts, List<String> userPostImages}),
            GetUserPostsUseCaseParams> {
  final UserPostsRepository _userPostRepository;

  GetUserPostsUseCase({required UserPostsRepository userPostRepository})
      : _userPostRepository = userPostRepository;
  @override
  Future<
      Either<Failure,
          ({List<PostEntity> userPosts, List<String> userPostImages})>> call(
      GetUserPostsUseCaseParams params) async {
    return await _userPostRepository.getAllPostsByUser(params.uid);
  }
}

class GetUserPostsUseCaseParams {
  final String uid;
  GetUserPostsUseCaseParams({
    required this.uid,
  });
}
