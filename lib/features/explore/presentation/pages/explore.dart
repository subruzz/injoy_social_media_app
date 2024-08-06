import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/localization.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recommended_post/get_recommended_post_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_hash_tag/search_hash_tag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_location_explore/search_location_explore_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_user/search_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/pages/explore_all_posts.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/tab/explore_tab.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
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

  final ValueNotifier<int> _currentTab = ValueNotifier(0);

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomAppPadding(
          padding: AppPadding.medium,
          child: Column(
            children: [
              CustomTextField(
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
              AppSizedBox.sizedBox10H,
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
    );
  }
}
