import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/utils/other/debouncer.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_bar_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recommended_post/get_recommended_post_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_hash_tag/search_hash_tag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_location_explore/search_location_explore_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_user/search_user_cubit.dart';
import 'package:social_media_app/core/widgets/explore_all_posts.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/tab/explore_tab.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key, this.focusNodeForExplore});
  final FocusNode? focusNodeForExplore;

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;
  String _lastSearchQuery = '';
  final ValueNotifier<bool> _isTextEntered = ValueNotifier(false);
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));
  final ValueNotifier<int> _currentTab = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _currentTab.value = _tabController.index;

        _performSearch();
      }
    });
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    // if (query == _lastSearchQuery) return;

    final currentTabIndex = _tabController.index;
    _lastSearchQuery = query;
    if (currentTabIndex == 0) {
      final searchUser = context.read<SearchUserCubit>();
      final searchState = searchUser.state;
      if (searchState is SearchUserSuccess &&
          searchState.query == _lastSearchQuery) {
        return;
      }
      searchUser.searchUser(query);
    } else if (currentTabIndex == 1) {
      final recommendedPosts = context.read<GetRecommendedPostCubit>();
      final searchState = recommendedPosts.state;
      if (searchState is GetRecommendedPostSuccess &&
          searchState.query == _lastSearchQuery) {
        return;
      }
      context.read<GetRecommendedPostCubit>().getRecommendedPosts(query);
    } else if (currentTabIndex == 2) {
      final searchHashtags = context.read<SearchHashTagCubit>();
      final searchState = searchHashtags.state;
      if (searchState is SearchHashTagSuccess &&
          searchState.query == _lastSearchQuery) {
        return;
      }
      context.read<SearchHashTagCubit>().searchHashTags(query);
    } else if (currentTabIndex == 3) {
      final searchLocation = context.read<SearchLocationExploreCubit>();
      final searchState = searchLocation.state;
      if (searchState is SearchLocationSuccess &&
          searchState.query == _lastSearchQuery) {
        return;
      }
      context.read<SearchLocationExploreCubit>().searchLocations(query);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopScope(
      canPop: _searchController.text.isEmpty,
      onPopInvoked: (didPop) {
        _searchController.clear();
        context
            .read<BottomBarCubit>()
            .changePoppingBehavOfExplore(false);
        _isTextEntered.value = false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: WebWidthHelper(
            width: 800,
            child: CustomAppPadding(
              padding: AppPadding.medium,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    focusNode: widget.focusNodeForExplore,
                    autoFocus: false,
                    onChanged: (value) {
                      _debouncer.run(() {
                        _isTextEntered.value = value.isNotEmpty;
                        _performSearch();
                      });
                    },
                    // prefixIcon: Icons.search,
                    controller: _searchController,
                    hintText: '${l10n!.search} ...',
                  ),
                  isThatTabOrDeskTop
                      ? AppSizedBox.sizedBox20H
                      : AppSizedBox.sizedBox10H,
                  ValueListenableBuilder(
                    valueListenable: _isTextEntered,
                    builder: (context, value, child) {
                      if (value) {
                        return ExploreTab(
                          tabController: _tabController,
                          currentTab: _currentTab,
                        );
                      } else {
                        return const ExploreAllPosts();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
