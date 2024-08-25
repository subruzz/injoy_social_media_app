import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/features/explore/presentation/widgets/tag_or_location_posts/widgets/shorts_of_tag.dart';
import 'package:social_media_app/features/explore/presentation/widgets/tag_or_location_posts/widgets/hashtag_or_location_posts.dart';

class HashtagPostsTabBarSection extends StatelessWidget {
  const HashtagPostsTabBarSection(
      {super.key, this.isLoc = false, required this.tagOrLocation});
  final String tagOrLocation;
  final bool isLoc;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          padding: AppPadding.small,
          indicatorWeight: 3,
          tabs: [
            Text(
              'Posts',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              'Shorts',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              HashtagOrLocationPosts(
                tagOrLocation: tagOrLocation,
              ),
              ShortsOfLocationORTag(name: tagOrLocation),
            ],
          ),
        ),
      ],
    );
  }
}
