import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/settings/domain/repository/settings_repository.dart';

class DeleteChatUsecase implements UseCase<Unit, DeleteChatUsecaseParams> {
  final SettingsRepository _settingsRepository;

  DeleteChatUsecase({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  @override
  Future<Either<Failure, Unit>> call(DeleteChatUsecaseParams params) async {
    return await _settingsRepository.clearAllChats(
      params.myId,
    );
  }
}

class DeleteChatUsecaseParams {
  final String myId;

  DeleteChatUsecaseParams({
    required this.myId,
  });
}
