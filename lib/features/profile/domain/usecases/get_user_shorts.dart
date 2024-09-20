// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/repository/user_dat_repository.dart';

import '../../../../core/common/models/partial_user_model.dart';

class GetUserShortsUseCase
    implements UseCase<List<PostEntity>, GetUserShortsUseCaseParams> {
  final UserDatRepository _userPostRepository;

  GetUserShortsUseCase({required UserDatRepository userPostRepository})
      : _userPostRepository = userPostRepository;
  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetUserShortsUseCaseParams params) async {
    return await _userPostRepository.getShorts(params.user);
  }
}

class GetUserShortsUseCaseParams {
  final PartialUser user;
  GetUserShortsUseCaseParams({
    required this.user,
  });
}
