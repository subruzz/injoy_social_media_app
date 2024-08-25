import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';

import '../entities/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Unit>> sendMessage(
      ChatEntity chat, List<MessageEntity> message);
  Stream<Either<Failure, List<ChatEntity>>> getMyChat(String myId);
  Stream<Either<Failure, List<MessageEntity>>> getSingleUserMessages(
      String sendorId, String recipientId);
  Future<Either<Failure, Unit>> deleteMessage(List<MessageEntity> messages);
  Future<Either<Failure, Unit>> seenMessageUpdate(
      String sendorId, String recieverId, String messageId);

  Future<Either<Failure, Unit>> deleteChat(String myid);
}
