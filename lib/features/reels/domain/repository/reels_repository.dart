import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';

import '../../../../core/common/entities/post.dart';
import '../../data/datasource/reels_data_source.dart';

abstract interface class ReelsRepository {
  Future<Either<Failure, GetReelsResponse>> getRandomReels(
      String myId, DocumentSnapshot? lastDocument);
}
