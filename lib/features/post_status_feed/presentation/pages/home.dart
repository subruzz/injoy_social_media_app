import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/floating_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_top_bar_section/home_top_bar.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_tab_bar_section/home_tab_bar_section.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/user_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      appBar: HomeTopBar(
        isPremium: context.read<AppUserBloc>().appUser.hasPremium,
        profile: context.read<AppUserBloc>().appUser.profilePic,
      ),
      body: SafeArea(
        child: Center(
          child: DefaultTabController(
            length: 2,
            child: RefreshIndicator(
              onRefresh: () async {
                // context.read<InitialSetupCubit>().startInitialSetup(
                //     uId: context.read<AppUserBloc>().appUser.id);
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverList(
                        delegate: SliverChildListDelegate(
                            [AppSizedBox.sizedBox5H, const UserStatus()]))
                  ];
                },
                body: const HomeTabBarSection(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
