import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/hashtag_search_tab/hashtag_search_tab.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/location_search_tab/location_search_tab.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/recommened_posts_tab/recommended_posts_tab.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/tab/tab_model.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/user_search_tab/user_search_tab.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab(
      {super.key, required this.tabController, required this.currentTab});
  final TabController tabController;
  final ValueNotifier<int> currentTab;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: currentTab,
            builder: (context, value, child) {
              return TabBar(
                labelColor: AppDarkColor().secondaryPrimaryText,
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppDarkColor().buttonBackground,
                tabs: [
                  Tab(
                    icon: ExploreTabIcons(
                      asset: AppAssetsConst.person,
                      isSelected: value == 0,
                    ),
                  ),
                  Tab(
                    icon: ExploreTabIcons(
                      asset: AppAssetsConst.explore,
                      isSelected: value == 1,
                    ),
                  ),
                  Tab(
                    icon: ExploreTabIcons(
                      asset: AppAssetsConst.hashtag,
                      h: true,
                      isSelected: value == 2,
                    ),
                  ),
                  Tab(
                    icon: ExploreTabIcons(
                      asset: AppAssetsConst.locationIcon,
                      isSelected: value == 3,
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                UserSearchTab(),
                RecommendedPostsTab(),
                HashtagSearchTab(),
                LocationSearchTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
