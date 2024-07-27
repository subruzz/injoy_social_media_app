import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/utils/id_generator.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_single_user_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/seen_message_update_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/notification.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageInfoStoreCubit _messageInfoStoreCubit;
  final SendMessageUseCase _sendMessageUseCase;
  final DeleteMessageUsecase _deleteMessageUsecase;
  final GetSingleUserMessageUsecase _getSingleUserMessageUsecase;
  final SeenMessageUpdateUsecase _seenMessageUpdateUsecase;
  MessageCubit(
      this._sendMessageUseCase,
      this._getSingleUserMessageUsecase,
      this._messageInfoStoreCubit,
      this._deleteMessageUsecase,
      this._seenMessageUpdateUsecase)
      : super(MessageInitial());
  Future<void> getPersonalChats(
      {required String sendorId, required String recipientId}) async {
    emit(MessageLoading());
    final streamRes = _getSingleUserMessageUsecase.call(sendorId, recipientId);
    await for (var value in streamRes) {
      value.fold(
        (failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) => emit(
          MessageLoaded(messages: success),
        ),
      );
    }
  }

  Future<void> sendMessage({
    required String recentTextMessage,
    required String? messageType,
    List<SelectedByte>? selectedAssets,
    List<String>? captions,
  }) async {
    final messageInfoState = _messageInfoStoreCubit.state;
    final MessageReplyClicked? replyState =
        messageInfoState is MessageReplyClicked ? messageInfoState : null;

    final newChat = ChatEntity(
        senderUid: _messageInfoStoreCubit.senderId,
        recipientUid: _messageInfoStoreCubit.receiverId,
        recipientName: _messageInfoStoreCubit.receiverName,
        recentTextMessage: '',
        recipientProfile: _messageInfoStoreCubit.receiverProfile,
        totalUnReadMessages: 0,
        createdAt: Timestamp.now());
    List<MessageEntity> multipleMessages = [];
    MessageEntity? newMessge;
    if (selectedAssets != null &&
        captions != null &&
        selectedAssets.isNotEmpty &&
        selectedAssets.length == captions.length) {
      for (int assets = 0; assets < selectedAssets.length; assets++) {
        log('correct${selectedAssets[assets]}');
        final newMessage = MessageEntity(
            isDeleted: false,
            createdAt: null,
            repliedMessage: replyState?.caption,
            repliedMessageAssetLink: replyState?.assetPath,
            repliedMessageType: replyState?.messageType,
            repliedTo: replyState?.userName,
            message: captions[assets],
            isEdited: false,
            deletedAt: null,
            assetPath: selectedAssets[assets],
            senderUid: _messageInfoStoreCubit.senderId,
            recipientUid: _messageInfoStoreCubit.receiverId,
            messageType: selectedAssets[assets].mediaType == MediaType.photo
                ? MessageTypeConst.photoMessage
                : MessageTypeConst.videoMessage,
            isSeen: false,
            messageId: IdGenerator.generateUniqueId());
        multipleMessages.add(newMessage);
      }
    } else {
      newMessge = MessageEntity(
          isDeleted: false,
          createdAt: null,
          message: recentTextMessage,
          isEdited: false,
          deletedAt: null,
          repliedMessage: replyState?.caption,
          repliedMessageAssetLink: replyState?.assetPath,
          repliedMessageType: replyState?.messageType,
          repliedTo: replyState?.userName,
          senderUid: _messageInfoStoreCubit.senderId,
          recipientUid: _messageInfoStoreCubit.receiverId,
          messageType: messageType ?? MessageTypeConst.textMessage,
          isSeen: false,
          messageId: IdGenerator.generateUniqueId());
    }
    _messageInfoStoreCubit.replyRemoved();
    // await PushNotificiationServices.sendNotificationToUser('');
    final res = await _sendMessageUseCase(SendMessageUseCaseParams(
        chat: newChat,
        message: selectedAssets != null ? multipleMessages : [newMessge!]));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {});
  }

  void deleteMessage({required String messageId}) async {
    final res = await _deleteMessageUsecase(DeleteMessageUsecaseParams(
        sendorId: _messageInfoStoreCubit.senderId,
        recieverId: _messageInfoStoreCubit.receiverId,
        messageId: messageId));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {});
  }

  void seeMessage({required String messageId}) async {
    final res = await _seenMessageUpdateUsecase(SeenMessageUpdateUsecaseParams(
        sendorId: _messageInfoStoreCubit.senderId,
        recieverId: _messageInfoStoreCubit.receiverId,
        messageId: messageId));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {});
  }
}
