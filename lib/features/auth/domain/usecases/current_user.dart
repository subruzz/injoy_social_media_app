import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class CurrentUser implements UseCase<AppUser, NoParams> {
  final AuthRepository _authRepository;

  CurrentUser(this._authRepository);
  @override
  Future<Either<Failure, AppUser>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}
