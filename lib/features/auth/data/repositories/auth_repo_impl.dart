import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/firebase_auth_errors.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authremoteDataSource})
      : _remoteDataSource = authremoteDataSource;

  @override
  Future<Either<Failure, String>> getCurrentUserId() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return right(unit);
    } on AuthError catch (e) {
      return left(
        Failure(
          e.dialogTitle,
          e.dialogText,
        ),
      );
    } on MainException catch (e) {
      return left(
        Failure(e.errorMsg, e.details),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> googleSignIn() async {
    try {
      final user = await _remoteDataSource.googleSignIn();
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
        Failure(e.errorMsg, e.details),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> login(String email, String password) async {
    try {
      final user = await _remoteDataSource.login(email, password);
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
        Failure(e.errorMsg, e.details),
      );
    }
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
        Failure(e.errorMsg, e.details),
      );
    }
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
        Failure(e.errorMsg, e.details),
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
  Future<Either<Failure, Unit>> logout(String userId) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  
}
