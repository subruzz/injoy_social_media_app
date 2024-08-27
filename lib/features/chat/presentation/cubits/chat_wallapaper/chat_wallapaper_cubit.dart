import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/core/utils/shared_preference/chat_wallapaper.dart';

part 'chat_wallapaper_state.dart';

class ChatWallapaperCubit extends Cubit<ChatWallapaperState> {
  ChatWallapaperCubit() : super(ChatWallapaperInitial());
  final chatWallapaper = 'chat_wallpaper';

  void storechatWallapaper(File file) async {
    emit(ChatWallapaperLoading());

    final res = await ChatWallapaperSp.storechatWallapaper(file);
    if (res) {
      emit(ChatWallapaperStored());
      emit(ChatWallapaperSuccess(wallapaperPath: file.path));
    } else {
      emit(ChatWallapaperError());
    }
  }

  void getChatWallapaper() async {
    try {
      final chatImage = await ChatWallapaperSp.getChatWallapaper();

      if (chatImage == null) {
        emit(ChatWallapaperError());
        return;
      }

      emit(ChatWallapaperSuccess(wallapaperPath: chatImage));
    } catch (e) {
      log(e.toString());
      emit(ChatWallapaperError());
    }
  }
  void init()
  {
    emit(ChatWallapaperInitial());
  }
}
