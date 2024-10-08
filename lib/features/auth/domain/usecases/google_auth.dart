import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class GoogleAuthUseCase implements UseCase<AppUser, NoParams> {
  final AuthRepository _authRepository;

  GoogleAuthUseCase(this._authRepository);
  @override
  Future<Either<Failure, AppUser>> call(NoParams params) async {
    return await _authRepository.googleSignIn();
  }
}
