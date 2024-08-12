import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(const AppLanguageState(Locale('en'))) {
    _loadLanguage();
  }

  static const String _languageCodeKey = 'languageCode';

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageCodeKey) ?? 'en'; //
    final locale = Locale(languageCode);
    emit(state.copyWith(locale: locale));
  }

  Future<void> changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, locale.languageCode); 
    emit(state.copyWith(locale: locale));
  }
}
