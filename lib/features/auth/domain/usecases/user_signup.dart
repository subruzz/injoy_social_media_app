import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class UserSignup implements UseCase<AppUser, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignup({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, AppUser>> call(UserSignUpParams params) async {
    return await _authRepository.signup(params.email, params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.password,
  });
}
