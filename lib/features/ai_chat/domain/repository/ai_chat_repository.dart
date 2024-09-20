import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/features/ai_chat/domain/enitity/ai_chat_entity.dart';

import '../../../../core/utils/errors/failure.dart';

abstract interface class AiChatRepository {
  Future<Either<Failure, String>> sendAndGetChat(
      List<AiChatEntity> prevMessages, String message);
}
