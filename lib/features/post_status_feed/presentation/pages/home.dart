import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/floating_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_top_bar_section/home_top_bar.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/user_status.dart';
import '../../../status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import '../widgets/sections/home_tab_bar_section/widgets/following_post_tab_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      body: RefreshIndicator(
        onRefresh: () async {
          if (context.mounted) {
            context.read<FollowingPostFeedBloc>().add(
                FollowingPostFeedGetEvent(following: me.following, uId: me.id));
            context
                .read<GetAllStatusBloc>()
                .add(GetAllstatusesEvent(uId: me.id));
          }
        },
        child: CustomScrollView(
          slivers: [
            HomeTopBar(
              isPremium: me.hasPremium,
            ),
            SliverPadding(
              padding: AppPadding.onlyTopExtraSmall,
              sliver: const SliverToBoxAdapter(
                child: UserStatus(),
              ),
            ),
            const FollowingPostTabView()
          ],
        ),
      ),
    );
  }
}
