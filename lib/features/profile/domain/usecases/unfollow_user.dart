// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/other_user_repository.dart';

class UnfollowUserUseCase implements UseCase<Unit, UnfollowUserUseCaseParms> {
  final OtherUserRepository _otherUserRepository;

  UnfollowUserUseCase({required OtherUserRepository userProfileRepository})
      : _otherUserRepository = userProfileRepository;
  @override
  Future<Either<Failure, Unit>> call(UnfollowUserUseCaseParms params) async {
    return await _otherUserRepository.unfollowUser(params.myUid,params.otherUserUid);
  }
}

class UnfollowUserUseCaseParms {
  final String myUid;
  final String otherUserUid;
  UnfollowUserUseCaseParms({
    required this.otherUserUid,
    required this.myUid,
  });
}
