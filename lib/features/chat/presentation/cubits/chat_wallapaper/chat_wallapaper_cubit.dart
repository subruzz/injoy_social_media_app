import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chat_wallapaper_state.dart';

class ChatWallapaperCubit extends Cubit<ChatWallapaperState> {
  ChatWallapaperCubit() : super(ChatWallapaperInitial());
  final chatWallapaper = 'chat_wallpaper';

  void storechatWallapaper(File file) async {
    emit(ChatWallapaperLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.clear();
      // Store the new wallpaper file path
      await prefs.setString(chatWallapaper, file.path);
      emit(ChatWallapaperStored());
      emit(ChatWallapaperSuccess(wallapaperPath: file.path));
      log('Stored new wallpaper');
    } catch (e) {
      log('Exception: $e');
      emit(ChatWallapaperError());
    }
  }

  void getChatWallapaper() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? chatImage = prefs.getString(chatWallapaper);
      log('image file is $chatImage');

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
}
