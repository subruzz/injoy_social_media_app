// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/reels/domain/repository/reels_repository.dart';

import '../../data/datasource/reels_data_source.dart';

class GetReelsUseCase
    implements UseCase<GetReelsResponse, GetReelsUseCaseParams> {
  final ReelsRepository _reelsRepository;

  GetReelsUseCase({required ReelsRepository reelsRepository})
      : _reelsRepository = reelsRepository;

  @override
  Future<Either<Failure, GetReelsResponse>> call(params) async {
    return await _reelsRepository.getRandomReels(params.myId, params.lastDoc);
  }
}

class GetReelsUseCaseParams {
  final String myId;
  final DocumentSnapshot? lastDoc;
  GetReelsUseCaseParams({
    required this.myId,
    required this.lastDoc,
  });
}
