import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/animation/animated_border.dart';
import 'package:social_media_app/core/widgets/animation/border_widget.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/widgets/create_status_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/for_you_posts/get_my_status/get_my_status_bloc.dart';
import '../../../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../../core/widgets/common/user_profile.dart';
import '../../../../../../../core/utils/routes/tranistions/app_routes_const.dart';
import '../../../../../../../core/widgets/common/empty_display.dart';

class MyStatusView extends StatefulWidget {
  const MyStatusView({super.key});

  @override
  State<MyStatusView> createState() => MyStatusViewState();
}

class MyStatusViewState extends State<MyStatusView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    return BlocBuilder<GetMyStatusBloc, GetMyStatusState>(
      builder: (context, state) {
        return CustomAppPadding(
          padding: AppPadding.only(left: 25, right: 18),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomPaint(
                    painter: StatusDottedBordersWidget(
                      numberOfStories: state is GetMyStatusSuccess
                          ? state.myStatus.length
                          : 0,
                      isMe: true,
                      spaceLength: 6,
                      images: state is GetMyStatusSuccess ? state.myStatus : [],
                      uid: user.id,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          if (state is GetMyStatusSuccess) {
                            log('state isthis $state and length of the items is ${state.myStatus.length}');
                          }
                          if (state is GetMyStatusSuccess &&
                              state.myStatus.isNotEmpty) {
                            Navigator.pushNamed(
                                context, MyAppRouteConst.viewStatusRoute,
                                arguments: {
                                  'isMe': true,
                                  'index': 0,
                                  'myStatuses': state.myStatus
                                });
                          } else {
                            Navigator.pushNamed(
                                context, MyAppRouteConst.statusCreationRoute);
                          }
                        },
                        child: Hero(
                            tag: user.id,
                            child: BlocBuilder<AppUserBloc, AppUserState>(
                              buildWhen: (previous, current) {
                                if (previous is AppUserLoggedIn &&
                                    current is AppUserLoggedIn) {
                                  return (previous.user.profilePic !=
                                      current.user.profilePic);
                                }
                                return false;
                              },
                              builder: (context, state) {
                                return state is AppUserLoggedIn
                                    ? CircularUserProfile(
                                        profile: state.user.profilePic)
                                    : const EmptyDisplay();
                              },
                            ))),
                  ),
                  const CreateStatusButton()
                ],
              ),
              AppSizedBox.sizedBox5H,
              const Text(
                'You',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        );
      },
    );
  }
}
