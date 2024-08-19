import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';

import 'package:social_media_app/core/partial_user_widget.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_followers_list/get_followers_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_following_list/get_following_list_cubit.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

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
                  following: context.read<AppUserBloc>().appUser.following),
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
                    const TabBar(
                   
                      tabs: [
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
                                      return PartialUserWidget(
                                          user: state.following[index]);
                                    });
                              }
                              return const EmptyDisplay();
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
                                      return PartialUserWidget(
                                          user: state.followers[index]);
                                    });
                              }
                              return const  EmptyDisplay();
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
