import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_my_chats_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMyChatsUsecase _getMyChatsUsecase;
  ChatCubit(this._getMyChatsUsecase) : super(ChatInitial());

  Future<void> getMyChats({required ChatEntity chat}) async {
    final streamRes = _getMyChatsUsecase.call(chat);
    await for (var value in streamRes) {
      emit(ChatLoading());
      value.fold((failure) => emit(ChatFailure(errorMsg: failure.message)),
          (success) => emit(ChatLoaded(chatItems: success)));
    }
  }
}
