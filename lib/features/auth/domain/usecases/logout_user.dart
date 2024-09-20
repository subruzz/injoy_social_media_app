import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class LogoutUserUseCase implements UseCase<Unit, LogoutUserUseCaseParams> {
  final AuthRepository _authRepository;

  LogoutUserUseCase(this._authRepository);
  @override
  Future<Either<Failure, Unit>> call(LogoutUserUseCaseParams params) async {
    return await _authRepository.logout(params.userId);
  }
}

class LogoutUserUseCaseParams {
  final String userId;

  LogoutUserUseCaseParams({required this.userId});
}
