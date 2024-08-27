import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/shared_preference/app_language.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(const AppLanguageState(Locale('en'))) {
    _loadLanguage();
  }
  void setInitial() {
    emit(state.copyWith(locale: const Locale('en')));
  }

  Future<void> _loadLanguage() async {
    final locale = await AppLanguageSP.loadLanguage();
    emit(state.copyWith(locale: locale));
  }

  Future<void> changeLanguage(Locale locale) async {
    final isChanged = await AppLanguageSP.changeLanguage(locale);
    if (isChanged) {
      emit(state.copyWith(locale: locale));
    }
  }
}
