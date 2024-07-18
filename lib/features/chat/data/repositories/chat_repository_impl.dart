import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource _chatRemoteDatasource;

  ChatRepositoryImpl({required ChatRemoteDatasource chatRemoteDatasource})
      : _chatRemoteDatasource = chatRemoteDatasource;
  @override
  Future<Either<Failure, Unit>> deleteChat(ChatEntity chat) async {
    try {
      await _chatRemoteDatasource.deleteChat(chat);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage(MessageEntity message) async {
    try {
      await _chatRemoteDatasource.deleteMessage(message);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getSingleUserMessages(
      MessageEntity message) async* {
    try {
      await for (final messages
          in _chatRemoteDatasource.getSingleUserMessages(message)) {
        yield Right(messages);
      }
    } on SocketException catch (e) {
      yield Left(Failure(e.toString()));
    } catch (e) {
      yield Left(Failure());
    }
  }

  @override
  Stream<Either<Failure, List<ChatEntity>>> getMyChat(ChatEntity chat) async* {
    try {
      await for (final chats in _chatRemoteDatasource.getMyChat(chat)) {
        yield Right(chats);
      }
    } on SocketException catch (e) {
      yield Left(Failure(e.toString()));
    } catch (e) {
      yield Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> seenMessageUpdate(MessageEntity message) async {
    try {
      await _chatRemoteDatasource.seenMessageUpdate(message);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      ChatEntity chat, MessageEntity message) async {
    try {
      await _chatRemoteDatasource.sendMessage(chat, message);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
