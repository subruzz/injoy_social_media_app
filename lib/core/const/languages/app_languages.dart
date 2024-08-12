import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/shared_providers/cubit/app_language/app_language_cubit.dart';

class AppLanguages {
  static const ml = Locale('ml');
  static const en = Locale('en');
  static bool isMalayalamLocale(BuildContext context) {
    return context.read<AppLanguageCubit>().state.locale == ml;
  }
}
