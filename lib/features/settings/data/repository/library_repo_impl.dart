import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';

import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/settings/data/datasource/library_data_source.dart';

import '../../domain/repository/library_repostory.dart';

class LibraryRepoImpl implements LibraryRepostory {
  final LibraryDataSource _libraryDataSource;

  LibraryRepoImpl({required LibraryDataSource libraryDataSource})
      : _libraryDataSource = libraryDataSource;
  @override
  Future<Either<Failure, List<PostEntity>>> getSavedPosts(
      {required List<String> savedPostsId}) async {
    try {
      final res =
          await _libraryDataSource.getSavedPosts(savedPosts: savedPostsId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getLikedPosts(
      {required String myId}) async {
    try {
      final res = await _libraryDataSource.getLikedPosts(myId: myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure());
    }
  }
}
