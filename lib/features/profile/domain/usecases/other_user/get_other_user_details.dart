// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/other_user_repository.dart';

class GetOtherUserDetailsUseCase
    implements UseCase<AppUser, GetOtherUserDetailsUseCaseParms> {
  final OtherUserRepository _otherUserRepository;

  GetOtherUserDetailsUseCase(
      {required OtherUserRepository userProfileRepository})
      : _otherUserRepository = userProfileRepository;
  @override
  Future<Either<Failure, AppUser>> call(
      GetOtherUserDetailsUseCaseParms params) async {
    return await _otherUserRepository.getOtherUserProfile(params.uid);
  }
}

class GetOtherUserDetailsUseCaseParms {
  final String uid;
  GetOtherUserDetailsUseCaseParms({
    required this.uid,
  });
}
