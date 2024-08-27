import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageSP {
  static const String _languageCodeKey = 'languageCode';

  static Future<Locale> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageCodeKey) ?? 'en';
    final locale = Locale(languageCode);
    return locale;
  }

  static Future<bool> changeLanguage(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageCodeKey, locale.languageCode);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> clearLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languageCodeKey);
  }
}
