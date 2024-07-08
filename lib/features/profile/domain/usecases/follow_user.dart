// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/other_user_repository.dart';

class FollowUserUseCase implements UseCase<Unit, FollowUserUseCaseParms> {
  final OtherUserRepository _otherUserRepository;

  FollowUserUseCase({required OtherUserRepository userProfileRepository})
      : _otherUserRepository = userProfileRepository;
  @override
  Future<Either<Failure, Unit>> call(FollowUserUseCaseParms params) async {
    return await _otherUserRepository.followUser(params.myUid,params.otherUserUid);
  }
}

class FollowUserUseCaseParms {
  final String myUid;
  final String otherUserUid;
  FollowUserUseCaseParms({
    required this.otherUserUid,
    required this.myUid,
  });
}
