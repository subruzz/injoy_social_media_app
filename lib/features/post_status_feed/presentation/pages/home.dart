import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart%20';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/floating_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_top_bar_section/home_top_bar.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/user_status.dart';
import '../../../../core/utils/di/init_dependecies.dart';
import '../../../notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import '../bloc/get_all_statsus/get_all_status_bloc.dart';
import '../widgets/sections/home_tab_bar_section/widgets/following_post_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final bloc = BlocProvider.of<FollowingPostFeedBloc>(context);
      final state = bloc.state;
      final user = context.read<AppUserBloc>().appUser;
      if (state is FollowingPostFeedSuccess && state.hasMore) {
        bloc.add(FollowingPostFeedGetEvent(
          uId: user.id,
          following: user.following,
          isLoadMore: true,
          lastDoc: state.lastDoc,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final me = context.read<AppUserBloc>().appUser;
    return BlocProvider(
      create: (context) => serviceLocator<NotificationCubit>()
        ..getMynotifications(myId: context.read<AppUserBloc>().appUser.id),
      child: Scaffold(
        floatingActionButton: FloatingButton(
          l10n: l10n!,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            if (context.mounted) {
              context.read<FollowingPostFeedBloc>().add(
                  FollowingPostFeedGetEvent(
                      following: me.following, uId: me.id, isFirst: true));
              context
                  .read<GetAllStatusBloc>()
                  .add(GetAllstatusesEvent(uId: me.id));
            }
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (Responsive.isMobile(context)) const HomeTopBar(),
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
      ),
    );
  }
}
