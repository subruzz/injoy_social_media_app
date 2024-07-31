import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/floating_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_top_bar_section/home_top_bar.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_tab_bar_section/home_tab_bar_section.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/user_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      appBar: HomeTopBar(
        isPremium: me.hasPremium,
        profile: me.profilePic,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: NestedScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  AppSizedBox.sizedBox5H,
                  const UserStatus(),
                ]),
              ),
            ];
          },
          body:
              const DefaultTabController(length: 2, child: HomeTabBarSection()),
        ),
      ),
    );
  }
}
