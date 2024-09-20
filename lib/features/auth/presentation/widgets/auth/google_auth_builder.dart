import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/di/di.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/google_auth.dart';

import '../../bloc/google_auth/google_auth_bloc.dart';

class GoogleAuthBuilder extends StatelessWidget {
  const GoogleAuthBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => serviceLocator<GoogleAuthBloc>(),
        child: const GoogleAuthButton());
  }
}
