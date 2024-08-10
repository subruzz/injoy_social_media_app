// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/reels/domain/repository/reels_repository.dart';

class GetReelsUseCase
    implements UseCase<List<PostEntity>, GetReelsUseCaseParams> {
  final ReelsRepository _reelsRepository;

  GetReelsUseCase({required ReelsRepository reelsRepository})
      : _reelsRepository = reelsRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(params) async {
    return await _reelsRepository.getRandomReels(params.myId);
  }
}

class GetReelsUseCaseParams {
  final String myId;

  GetReelsUseCaseParams({required this.myId});
}
