// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/repository/user_posts_repository.dart';

class GetOtherUserPostsCase
    implements
        UseCase<({List<PostEntity> userPosts, List<String> userPostImages}),
            GetOtherUserPostsCaseParams> {
  final UserPostsRepository _userPostRepository;

  GetOtherUserPostsCase({required UserPostsRepository userPostRepository})
      : _userPostRepository = userPostRepository;
  @override
  Future<
      Either<Failure,
          ({List<PostEntity> userPosts, List<String> userPostImages})>> call(
      GetOtherUserPostsCaseParams params) async {
    return await _userPostRepository.getAllPostsByUser(params.uid);
  }
}

class GetOtherUserPostsCaseParams {
  final String uid;
  GetOtherUserPostsCaseParams({
    required this.uid,
  });
}
