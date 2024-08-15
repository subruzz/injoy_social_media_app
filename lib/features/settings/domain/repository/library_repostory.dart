import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';

abstract interface class LibraryRepostory {
  Future<Either<Failure, List<PostEntity>>> getSavedPosts(
      {required List<String> savedPostsId});
  Future<Either<Failure, List<PostEntity>>> getLikedPosts(
      {required String myId});
}
