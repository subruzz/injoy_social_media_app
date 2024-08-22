import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_bar_cubit.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';

class BottomBarBuilder extends StatelessWidget {
  const BottomBarBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBarCubit(),
      child: const BottonNavWithAnimatedIcons(),
    );
  }
}
