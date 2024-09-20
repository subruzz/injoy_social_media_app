import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/shared_providers/cubit/app_language/app_language_cubit.dart';

/// A class that manages application languages and locale checks.
class AppLanguages {
  /// Constant for Malayalam locale.
  static const ml = Locale('ml');

  /// Constant for English locale.
  static const en = Locale('en');

  /// Constant for Hindi locale.
  static const hi = Locale('hi');

  /// Checks if the current locale is Malayalam.
  ///
  /// Returns `true` if the locale is Malayalam, `false` otherwise.
  /// 
  /// Requires [AppLanguageCubit] to be provided in the widget tree.
  static bool isMalayalamLocale(BuildContext context) {
    return context.read<AppLanguageCubit>().state.locale == ml;
  }

  /// Checks if the current locale is Hindi.
  ///
  /// Returns `true` if the locale is Hindi, `false` otherwise.
  /// 
  /// Requires [AppLanguageCubit] to be provided in the widget tree.
  static bool isHindiLocale(BuildContext context) {
    return context.read<AppLanguageCubit>().state.locale == hi;
  }
}
