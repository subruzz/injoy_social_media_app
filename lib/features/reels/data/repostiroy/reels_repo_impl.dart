import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';

import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/reels/data/datasource/reels_data_source.dart';

import '../../domain/repository/reels_repository.dart';

class ReelsRepoImpl implements ReelsRepository {
  final ReelsDataSource _reelsDataSource;

  ReelsRepoImpl({required ReelsDataSource reelsDataSource})
      : _reelsDataSource = reelsDataSource;
  @override
  Future<Either<Failure, GetReelsResponse>> getRandomReels(
      String? excludedId, String myId, DocumentSnapshot? lastDocument) async {
    try {
      final res =
          await _reelsDataSource.getRandomReels(excludedId, myId, lastDocument);
      return right(res);
    } on MainException catch (e) {
      return left(Failure());
    }
  }
}
