import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/features/explore/presentation/widgets/view_hashtag_posts/widgets/recent_hashtag_posts.dart';
import 'package:social_media_app/features/explore/presentation/widgets/view_hashtag_posts/widgets/top_hash_tag_posts.dart';

class HashtagPostsTabBarSection extends StatelessWidget {
  const HashtagPostsTabBarSection({super.key, required this.hashtagName});
  final String hashtagName;
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
              'Top',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              'Recent',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              TopHashTagPosts(
                hashtagName: hashtagName,
              ),
              RecentHashtagPosts(hashtagName: hashtagName),
            ],
          ),
        ),
      ],
    );
  }
}
