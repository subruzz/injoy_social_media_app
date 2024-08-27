import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ChatWallapaperSp {
  static const chatWallapaper = 'chat_wallpaper';

  static Future<bool> storechatWallapaper(File file) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(chatWallapaper, file.path);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getChatWallapaper() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? chatImage = prefs.getString(chatWallapaper);
      return chatImage;
    } catch (e) {
      return null;
    }
  }

  static Future<void> clearChatWallapaper() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(chatWallapaper);
  }
}
