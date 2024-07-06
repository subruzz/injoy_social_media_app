import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class CheckUsernameExistUseCasse implements UseCase<bool, CheckUsernameExistUseCasseParams> {
  final    UserProfileRepository _profileRepository;


  CheckUsernameExistUseCasse({required UserProfileRepository profileRepository})
      : _profileRepository = profileRepository;
  @override
  Future<Either<Failure, bool>> call(CheckUsernameExistUseCasseParams params) async {
    return await _profileRepository.checkUserNameExist(params.userName);
  }
}

class CheckUsernameExistUseCasseParams {
  final String userName;
  

  CheckUsernameExistUseCasseParams({
    required this.userName,

  });
}
