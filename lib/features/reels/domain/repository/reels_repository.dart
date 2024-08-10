import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';

import '../../../../core/common/entities/post.dart';

abstract interface class ReelsRepository {
  Future<Either<Failure, List<PostEntity>>> getRandomReels(String myId);
}
