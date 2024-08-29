import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/services/app_interal/app_internal_service.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/other/get_last_message.dart';
import 'package:social_media_app/core/utils/other/id_generator.dart';
import 'package:social_media_app/features/chat/data/model/message_model.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/usecases/block_unblock_chat.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_single_chat.dart';
import 'package:social_media_app/features/chat/domain/usecases/seen_message_update_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/settings/domain/usecases/delete_chat_usecase.dart';

import '../../../../../../core/common/entities/user_entity.dart';
import '../../../../../../core/utils/di/init_dependecies.dart';
import '../../../../../notification/domain/entities/customnotifcation.dart';
import '../../../../../settings/domain/entity/ui_entity/enums.dart';
import '../../../../domain/entities/message_reply_entity.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final AppUserBloc _appUserBloc;
  final SendMessageUseCase _sendMessageUseCase;
  final DeleteMessageUsecase _deleteMessageUsecase;
  final SeenMessageUpdateUsecase _seenMessageUpdateUsecase;
  final BlockUnblockChatUseCase _blockUnblockChatUseCase;
  final DeleteSingleChatUseCase _deleteChatUsecase;
  Timer? _timer;
  int _elapsedSeconds = 0;
  final _audioRecorder = AudioRecorder();
  set setMessageReply(MessageEntity reply) {
    _messageReply = _messageReply;
  }

  StreamSubscription<AppUser>? _userSubscription;

  final ValueNotifier<MessageReplyClicked?> messageReplyNotifier =
      ValueNotifier(null);

  MessageReplyEntity _messageReply = MessageReplyEntity();
  MessageReplyEntity get getMessageReply => _messageReply;
  MessageCubit(
      this._sendMessageUseCase,
      this._deleteMessageUsecase,
      this._seenMessageUpdateUsecase,
      this._appUserBloc,
      this._blockUnblockChatUseCase,
      this._deleteChatUsecase)
      : super(MessageInitial());
  void replyClicked(
      {required bool isMe,
      required String messageType,
      String? assetPath,
      required String repliedMessagecreator,
      required GetMessageState otherUserState,
      String? caption}) {
    if (otherUserState.otherUser == null) return;
    messageReplyNotifier.value = MessageReplyClicked(
        userName: otherUserState.otherUser?.id == repliedMessagecreator
            ? otherUserState.otherUser?.userName ?? ''
            : _appUserBloc.appUser.userName ?? '',
        repliedToMe: isMe,
        repliedMessageCreator: repliedMessagecreator,
        messageType: messageType,
        assetPath: assetPath,
        caption: caption);
    // emit(MessageReplyClicked(
    //     userName: otherUserState.otherUser?.id == repliedMessagecreator
    //         ? otherUserState.otherUser?.userName ?? ''
    //         : _appUserBloc.appUser.userName ?? '',
    //     repliedToMe: isMe,
    //     repliedMessageCreator: repliedMessagecreator,
    //     messageType: messageType,
    //     assetPath: assetPath,
    //     caption: caption));
  }

  void initialState() {
    messageReplyNotifier.value = null;
    emit(MessageInitial());
  }

  void clearChat(GetMessageState messageState) async {
    if (messageState.otherUser == null) {
      log('null');
      return;
    }
    final otherUser = messageState.otherUser!;
    emit(ChatBlockLoading());
    final res = await _deleteChatUsecase(DeleteSingleChatUseCaseParams(
        myId: _appUserBloc.appUser.id, otherUserId: otherUser.id));

    res.fold((failure) => emit(ChatBlockError()),
        (success) => emit(ChatBlockSuccess()));
  }

  void blockOrUnblockThisChat(
      {required GetMessageState messageState, required bool isBlock}) async {
    if (messageState.otherUser == null) {
      log('null');
      return;
    }
    final otherUser = messageState.otherUser!;

    emit(ChatBlockLoading());
    final res = await _blockUnblockChatUseCase(BlockUnblockChatUseCaseParams(
        myId: _appUserBloc.appUser.id,
        otherUserId: otherUser.id,
        isBlock: isBlock));

    res.fold((failure) => emit(ChatBlockError()),
        (success) => emit(ChatBlockSuccess()));
  }

  Future<void> sendMessage({
    required String recentTextMessage,
    required String? messageType,
    List<SelectedByte>? selectedAssets,
    List<String>? captions,
    required GetMessageState messageState,
  }) async {
    if (messageState.otherUser == null) {
      log('null');
      return;
    }

    final otherUser = messageState.otherUser!;
    final MessageReplyClicked? replyState = messageReplyNotifier.value;
    // It's important to handle message loading here rather than at the start.
    // If we emit the loading state at the start and the reply state is active,
    // the reply state may be lost. This ensures that the loading state does not
    // interfere with or overwrite the current reply state.
    emit(MessageLoading());
    final lastMessageId = IdGenerator.generateUniqueId();
    final newChat = ChatEntity(
        lastMessageId: lastMessageId,
        lastSenderId: _appUserBloc.appUser.id,
        senderName: _appUserBloc.appUser.userName,
        senderProfile: _appUserBloc.appUser.profilePic,
        senderUid: _appUserBloc.appUser.id,
        recipientUid: otherUser.id,
        recipientName: otherUser.userName,
        recentTextMessage: '',
        recipientProfile: otherUser.profilePic,
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
        newMessge = MessageEntity(
            isDeleted: false,
            createdAt: null,
            isItReply: replyState != null,
            repliedToMe: replyState?.repliedToMe,
            repliedMessgeCreatorId: replyState?.repliedMessageCreator,
            repliedMessage: replyState?.caption,
            repliedMessageAssetLink: replyState?.assetPath,
            repliedMessageType: replyState?.messageType,
            repliedTo: replyState?.userName,
            message: captions[assets],
            isEdited: false,
            deletedAt: null,
            assetPath: selectedAssets[assets],
            senderUid: _appUserBloc.appUser.id,
            recipientUid: otherUser.id,
            messageType: selectedAssets[assets].mediaType == MediaType.photo
                ? MessageTypeConst.photoMessage
                : MessageTypeConst.videoMessage,
            isSeen: false,
            messageId: assets == selectedAssets.length - 1
                ? lastMessageId
                : IdGenerator.generateUniqueId());
        multipleMessages.add(newMessge);
      }
    } else {
      newMessge = MessageEntity(
          repliedToMe: replyState?.repliedToMe,
          isDeleted: false,
          isItReply: replyState != null,
          repliedMessgeCreatorId: replyState?.repliedMessageCreator,
          createdAt: null,
          message: recentTextMessage,
          isEdited: false,
          deletedAt: null,
          repliedMessage: replyState?.caption,
          repliedMessageAssetLink: replyState?.assetPath,
          repliedMessageType: replyState?.messageType,
          repliedTo: replyState?.userName,
          senderUid: _appUserBloc.appUser.id,
          recipientUid: otherUser.id,
          messageType: messageType ?? MessageTypeConst.textMessage,
          isSeen: false,
          messageId: lastMessageId);
    }
    // await PushNotificiationServices.sendNotificationToUser('');
    final res = await _sendMessageUseCase(SendMessageUseCaseParams(
        chat: newChat,
        message: selectedAssets != null ? multipleMessages : [newMessge!]));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {
      emit(MessageSuccess());
      if (otherUser.token.isEmpty) return;
      serviceLocator<FirebaseHelper>().createNotification(
        streamTokenFromMsg: otherUser.token,
        notificationPreferenceType: NotificationPreferenceEnum.messages,
        notification: CustomNotification(
          notificationId: IdGenerator.generateUniqueId(),
          text:
              "Send you a message \n${getRecentTextMessage(MessageModel.fromMessageEntity(newMessge!))}",
          time: Timestamp.now(),
          senderId: _appUserBloc.appUser.id,
          uniqueId: otherUser.id,
          receiverId: otherUser.id,
          isThatLike: false,
          isThatPost: false,
          personalUserName: _appUserBloc.appUser.userName ?? '',
          personalProfileImageUrl: _appUserBloc.appUser.profilePic,
          notificationType: NotificationType.chat,
          senderName: _appUserBloc.appUser.userName ?? '',
        ),
      );
    });
    // initialState();
  }

  void deleteMessage({
    required List<MessageEntity> messages,
    required GetMessageState messageState,
  }) async {
    if (messageState.otherUser == null) return;
    final res = await _deleteMessageUsecase(
        DeleteMessageUsecaseParams(messages: messages));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {
      emit(DeleteMessageSuccess());
    });
  }

  void voiceRecordingStarted() async {
    final res = await initAudioRecord(audioRecorder: _audioRecorder);

    if (!res) return;
    emit(VoiceMessageStarted());

    _elapsedSeconds = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      voiceRecordingOngoing();
    });
  }

  void voiceRecordingOngoing() {
    emit(VoiceMessageOngoing(durration: _elapsedSeconds));
  }

  void voiceRecordStopped(GetMessageState messageState) async {
    _timer?.cancel();
    emit(MessageInitial());
    String? audioPath = await _audioRecorder.stop();
    if (audioPath == null || messageState.otherUser == null) {
      return emit(
          const MessageFailure(errorMsg: 'Error sending voice message'));
    }

    final otherUser = messageState.otherUser!;
    final MessageReplyClicked? replyState = messageReplyNotifier.value;

    log('called');
    String lastMessageId = IdGenerator.generateUniqueId();
    final newChat = ChatEntity(
        lastMessageId: lastMessageId,
        lastSenderId: _appUserBloc.appUser.id,
        senderName: _appUserBloc.appUser.userName,
        senderProfile: _appUserBloc.appUser.profilePic,
        senderUid: _appUserBloc.appUser.id,
        recipientUid: otherUser.id,
        recipientName: otherUser.userName,
        recentTextMessage: '',
        recipientProfile: otherUser.profilePic,
        totalUnReadMessages: 0,
        createdAt: Timestamp.now());
    final file = File(audioPath);

    final newMessage = MessageEntity(
      isDeleted: false,
      createdAt: null,
      message: '',
      repliedToMe: replyState?.repliedToMe,
      isItReply: replyState != null,
      isEdited: false,
      assetPath: SelectedByte(
        mediaType: MediaType.audio,
        selectedFile: file,
      ),
      deletedAt: null,
      senderUid: _appUserBloc.appUser.id,
      recipientUid: otherUser.id,
      messageType: MessageTypeConst.audioMessage,
      isSeen: false,
      messageId: IdGenerator.generateUniqueId(),
      repliedMessgeCreatorId: replyState?.repliedMessageCreator,
      repliedMessage: replyState?.caption,
      repliedMessageAssetLink: replyState?.assetPath,
      repliedMessageType: replyState?.messageType,
      repliedTo: replyState?.userName,
    );
    final res = await _sendMessageUseCase(
        SendMessageUseCaseParams(chat: newChat, message: [newMessage]));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {
      if (otherUser.token.isEmpty) return;
      serviceLocator<FirebaseHelper>().createNotification(
        streamTokenFromMsg: otherUser.token,
        notificationPreferenceType: NotificationPreferenceEnum.messages,
        notification: CustomNotification(
          notificationId: IdGenerator.generateUniqueId(),
          text: "Send you a message 🎵 Audio ",
          time: Timestamp.now(),
          senderId: _appUserBloc.appUser.id,
          uniqueId: otherUser.id,
          receiverId: otherUser.id,
          isThatLike: false,
          isThatPost: false,
          personalUserName: _appUserBloc.appUser.userName ?? '',
          personalProfileImageUrl: _appUserBloc.appUser.profilePic,
          notificationType: NotificationType.post,
          senderName: _appUserBloc.appUser.userName ?? '',
        ),
      );
    });
  }

  // void seeMessage({required String messageId}) async {
  //   final res = await _seenMessageUpdateUsecase(SeenMessageUpdateUsecaseParams(
  //       sendorId: _messageInfoStoreCubit.senderId,
  //       recieverId: _messageInfoStoreCubit.receiverId,
  //       messageId: messageId));
  //   res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
  //       (success) {});
  // }
  @override
  Future<void> close() {
    _timer?.cancel();
    _audioRecorder.dispose();
    return super.close();
  }
}
