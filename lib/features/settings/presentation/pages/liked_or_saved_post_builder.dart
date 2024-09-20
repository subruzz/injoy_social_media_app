import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/settings/presentation/cubit/cubit/liked_or_saved_posts_cubit.dart';
import 'package:social_media_app/features/settings/presentation/pages/liked_or_saved_post_page.dart';

import '../../../../core/utils/di/di.dart';

class LikedOrSavedPostBuilder extends StatelessWidget {
  const LikedOrSavedPostBuilder({super.key, this.isLiked = true});
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    log(user.savedPosts.toString());
    return BlocProvider(
      create: (context) {
        final cubit = serviceLocator<LikedOrSavedPostsCubit>();
        if (isLiked) {
          cubit.getLikedPosts(user.id);
        } else {
          cubit.getSavedPosts(user.savedPosts);
        }
        return cubit;
      },
      child: LikedOrSavedPostPage(
        isLiked: isLiked,
      ),
    );
  }
}
