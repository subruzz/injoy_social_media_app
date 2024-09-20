import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:social_media_app/features/chat/data/model/chat_model.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource _chatRemoteDatasource;

  ChatRepositoryImpl({required ChatRemoteDatasource chatRemoteDatasource})
      : _chatRemoteDatasource = chatRemoteDatasource;
  @override
  Future<Either<Failure, Unit>> deleteChat(
      String myid, String otherUserId) async {
    try {
      await _chatRemoteDatasource.deleteChat(myid, otherUserId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage(
      List<MessageEntity> messages) async {
    try {
      await _chatRemoteDatasource.deleteMessage(messages);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getSingleUserMessages(
      String sendorId, String recipientId) async* {
    try {
      await for (final messages in _chatRemoteDatasource.getSingleUserMessages(
          sendorId, recipientId)) {
        yield Right(messages);
      }
    } on SocketException catch (e) {
      yield Left(Failure(e.toString()));
    } catch (e) {
      log(e.toString());
      yield Left(Failure());
    }
  }

  @override
  Stream<Either<Failure, List<ChatEntity>>> getMyChat(String myId) async* {
    try {
      await for (final chats in _chatRemoteDatasource.getMyChat(myId)) {
        yield Right(chats);
      }
    } on SocketException catch (e) {
      yield Left(Failure(e.toString()));
    } catch (e) {
      log(e.toString());
      yield Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> seenMessageUpdate(
      String sendorId, String recieverId, String messageId) async {
    try {
      await _chatRemoteDatasource.seenMessageUpdate(
          sendorId, recieverId, messageId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      ChatEntity chat, List<MessageEntity> message) async {
    try {
      final ChatModel chatModel = ChatModel.fromChatEntity(chat);
      // final MessageModel messageModel = MessageModel.fromMessageEntity(message);
      await _chatRemoteDatasource.sendMessage(chatModel, message);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> blockAndUnblockChat(
      String myId, String otherUserId, bool isBlock) async {
    try {
      await _chatRemoteDatasource.blockAndUnblockChat(
          myId, otherUserId, isBlock);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
