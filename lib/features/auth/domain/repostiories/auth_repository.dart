// auth_repository.dart
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AppUser>> login(String email, String password);
  Future<Either<Failure, AppUser>> signup(String email, String password);
  Future<Either<Failure, AppUser>> googleSignIn();
  Future<Either<Failure, AppUser>> forgotPassword(String email);
  Future<Either<Failure, AppUser>> verifyPassword(
      String code, String newPassword);
  Future<Either<Failure, AppUser>> getCurrentUser();
}
