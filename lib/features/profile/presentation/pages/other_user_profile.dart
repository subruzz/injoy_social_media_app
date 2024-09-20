import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/get_other_user_reels/get_other_user_shorts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_page_wrapper.dart';

import '../../../../core/utils/di/di.dart';

class OtherUserProfilePage extends StatefulWidget {
  const OtherUserProfilePage({
    super.key,
    required this.user,
  });
  final PartialUser user;

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  @override
  void initState() {
    super.initState();
    if (widget.user.id == context.read<AppUserBloc>().appUser.id) return;
    serviceLocator<FirebaseHelper>().addTheVisitedUser(
        visitedUserId: widget.user.id,
        myId: context.read<AppUserBloc>().appUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => serviceLocator<OtherProfileCubit>()
              ..getOtherProfile(widget.user.id),
          ),
          BlocProvider(
            create: (context) => serviceLocator<GetOtherUserPostsCubit>()
              ..getOtherUserPosts(widget.user),
          ),
          BlocProvider(
            create: (context) => serviceLocator<GetOtherUserShortsCubit>()
              ..getOtherUserShorts(widget.user),
          ),
        ],
        child: ProfilePageWrapper(
          isMe: false,
          userName: widget.user.userName,
        ));
  }
}
