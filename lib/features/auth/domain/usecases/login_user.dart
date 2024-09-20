import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class LoginUserUseCase implements UseCase<AppUser, LoginUserUseCaseParams> {
  final AuthRepository _authRepository;

  LoginUserUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, AppUser>> call(LoginUserUseCaseParams params) async {
    return await _authRepository.login(params.email, params.password);
  }
}

class LoginUserUseCaseParams {
  final String email;
  final String password;

  LoginUserUseCaseParams({
    required this.email,
    required this.password,
  });
}
