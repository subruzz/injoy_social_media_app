import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/auth_errors.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AppUser>> forgotPassword(String email) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUser>> googleSignIn() async {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUser>> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUser>> signup(String email, String password) async {
    try {
      final user = await _remoteDataSource.signup(email, password);
      return right(user);
    } on AuthError catch (e) {
      return left(
        Failure(
          e.dialogTitle,
          e.dialogText,
        ),
      );
    } on MainException catch (e) {
      return left(
        Failure(e.errorMsg),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> verifyPassword(
      String code, String newPassword) async {
    // TODO: implement verifyPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUser>> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      if (user == null) {
        return Left(Failure('No User Found'));
      }
      return Right(user);
    } on MainException catch (e) {
      return Left(
        Failure(e.errorMsg),
      );
    }
  }
}
