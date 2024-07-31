
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/status/domain/repository/status_repository.dart';

class CreateMultipleStatusUseCase
    implements UseCase<Unit, CreateMutlipleStatusUseCaseParams> {
  final StatusRepository _statusRepository;

  CreateMultipleStatusUseCase(
      {required StatusRepository createStatusRepository})
      : _statusRepository = createStatusRepository;
  @override
  Future<Either<Failure, Unit>> call(
      CreateMutlipleStatusUseCaseParams params) async {
    return await _statusRepository.createMultipleStatus(
        params.status, params.captions, params.assets);
  }
}

class CreateMutlipleStatusUseCaseParams {
  final StatusEntity status;
  final List<SelectedByte> assets;
  final List<String> captions;
  CreateMutlipleStatusUseCaseParams({
    required this.captions,
    required this.status,
    required this.assets,
  });
}
