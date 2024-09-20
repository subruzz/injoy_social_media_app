import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/settings/domain/usecases/delete_chat_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_my_chats_usecase.dart';

import '../../../../../core/utils/errors/failure.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMyChatsUsecase _getMyChatsUsecase;
  final DeleteChatUsecase _deleteChatUsecase;
  StreamSubscription<Either<Failure, List<ChatEntity>>>? _chatSubscription;

  ChatCubit(this._getMyChatsUsecase, this._deleteChatUsecase)
      : super(ChatInitial());

  Future<void> getMyChats({required String myId}) async {
    emit(ChatLoading());

    // Unsubscribe from any previous subscriptions
    _chatSubscription?.cancel();

    // Subscribe to the chat stream
    final streamRes = _getMyChatsUsecase.call(myId);
    _chatSubscription = streamRes.listen(
      (value) {
        value.fold(
          (failure) => emit(ChatFailure(errorMsg: failure.message)),
          (success) => emit(ChatLoaded(chatItems: success)),
        );
      },
      onError: (error) {
        emit(ChatFailure(errorMsg: error.toString()));
      },
    );
  }

  Future<void> deleteMyChats({required String myId}) async {
    emit(ChatLoading());

    final res = await _deleteChatUsecase(DeleteChatUsecaseParams(myId: myId));
    res.fold(
      (failure) => emit(ChatFailure(errorMsg: failure.message)),
      (success) {},
    );
  }

  @override
  Future<void> close() {
    // Ensure the subscription is canceled when the cubit is closed
    _chatSubscription?.cancel();
    return super.close();
  }
}
