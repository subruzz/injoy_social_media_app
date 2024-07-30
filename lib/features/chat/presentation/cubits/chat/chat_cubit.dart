import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_my_chats_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMyChatsUsecase _getMyChatsUsecase;
  final DeleteChatUsecase _deleteChatUsecase;
  ChatCubit(this._getMyChatsUsecase, this._deleteChatUsecase)
      : super(ChatInitial());

  Future<void> getMyChats({required String myId}) async {
    emit(ChatLoading());
    final streamRes = _getMyChatsUsecase.call(myId);
    await for (var value in streamRes) {
      value.fold((failure) => emit(ChatFailure(errorMsg: failure.message)),
          (success) => emit(ChatLoaded(chatItems: success)));
    }
  }

  Future<void> deleteMyChats({required String myId}) async {
    emit(ChatLoading());
    final res = await _deleteChatUsecase(DeleteChatUsecaseParams(myId: myId));

    res.fold((failure) => emit(ChatFailure(errorMsg: failure.message)),
        (success) {});
  }
}
