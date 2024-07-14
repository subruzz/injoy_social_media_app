import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/cubit/following_cubit.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_followers_list/get_followers_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_following_list/get_following_list_cubit.dart';
import 'package:social_media_app/init_dependecies.dart';

class SeeFollowersFollowingPage extends StatelessWidget {
  const SeeFollowersFollowingPage({super.key, required this.initialIndex});
  final int initialIndex;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => serviceLocator<GetFollowingListCubit>()
              ..getMyFollowingList(
                  myId: '',
                  following: context.read<FollowingCubit>().followingList),
          ),
          BlocProvider(
            create: (context) => serviceLocator<GetFollowersCubit>()
              ..getMyFollowersList(
                  myId: context.read<AppUserBloc>().appUser.id),
          ),
        ],
        child: SafeArea(
          child: Scaffold(
            body: DefaultTabController(
                initialIndex: initialIndex,
                length: 2,
                child: Column(
                  children: [
                    const TabBar(tabs: [
                      Tab(
                        text: 'Following',
                      ),
                      Tab(
                        text: 'Followers',
                      )
                    ]),
                    Expanded(
                      child: TabBarView(
                        children: [
                          BlocBuilder<GetFollowingListCubit,
                              GetFollowingListState>(
                            builder: (context, state) {
                              if (state is FollowingListLoaded) {
                                log('following loaded ${state.following}');

                                return ListView.builder(
                                    padding: AppPadding.small,
                                    itemCount: state.following.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: AppPadding.onlyBottomSmall,
                                        child: Row(
                                          children: [
                                            CircularUserProfile(
                                              size: 30,
                                            ),
                                            AppSizedBox.sizedBox15W,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('@Angelina'),
                                                Text('saholina')
                                              ],
                                            ),
                                            const Spacer(),
                                            CustomButton(
                                                height: 40,
                                                width: 100,
                                                radius: AppBorderRadius
                                                    .horizontalExtraLarge,
                                                child: Text('Follow'),
                                                onClick: () {})
                                          ],
                                        ),
                                      );
                                    });
                              }
                              return EmptyDisplay();
                            },
                          ),
                          BlocBuilder<GetFollowersCubit, GetFollowersState>(
                            builder: (context, state) {
                              if (state is FollowersListLoaded) {
                                log('followers loaded ${state.followers}');
                                return ListView.builder(
                                    padding: AppPadding.small,
                                    itemCount: state.followers.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: AppPadding.onlyBottomSmall,
                                        child: Row(
                                          children: [
                                            CircularUserProfile(
                                              size: 30,
                                            ),
                                            AppSizedBox.sizedBox15W,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('@Angelina'),
                                                Text('saholina')
                                              ],
                                            ),
                                            const Spacer(),
                                            CustomButton(
                                                height: 40,
                                                width: 100,
                                                radius: AppBorderRadius
                                                    .horizontalExtraLarge,
                                                child: Text('Follow'),
                                                onClick: () {})
                                          ],
                                        ),
                                      );
                                    });
                              }
                              return EmptyDisplay();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
