import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';

import '../../data/datasource/reels_data_source.dart';

abstract interface class ReelsRepository {
  Future<Either<Failure, GetReelsResponse>> getRandomReels(
      String? excludedId, String myId, DocumentSnapshot? lastDocument);
}
