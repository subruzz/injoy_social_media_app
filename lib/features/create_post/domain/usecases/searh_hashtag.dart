import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/features/create_post/domain/repositories/post_repository.dart';

class SearchHashTagUseCase
    implements UseCase<List<HashTag>, SearchHashTagUseCaseParms> {
  final PostRepository _postRepository;

  SearchHashTagUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, List<HashTag>>> call(
      SearchHashTagUseCaseParms params) async {
    return await _postRepository.searchHashTags(params.query);
  }
}

class SearchHashTagUseCaseParms {
  final String query;

  SearchHashTagUseCaseParms({required this.query});
}
