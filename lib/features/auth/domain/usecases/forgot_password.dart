import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class ForgotPasswordUseCase
    implements UseCase<Unit, ForgotPasswordUseCaseParams> {
  final AuthRepository _authRepository;

  ForgotPasswordUseCase(this._authRepository);
  @override
  Future<Either<Failure, Unit>> call(
      ForgotPasswordUseCaseParams params) async {
    return await _authRepository.forgotPassword(params.email);
  }
}

class ForgotPasswordUseCaseParams {
  final String email;

  ForgotPasswordUseCaseParams({required this.email});
}
