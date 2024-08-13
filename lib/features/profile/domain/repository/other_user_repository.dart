import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';

abstract class OtherUserRepository {
  Future<Either<Failure, AppUser>> getOtherUserProfile(String uid);
  Future<Either<Failure, Unit>> followUser(
    String currentUid,
    String otherUid,
  );
  Future<Either<Failure, Unit>> unfollowUser(
    String currentUid,
    String otherUid,
  );

}
