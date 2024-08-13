import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_hash_tag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_shorts_of_tag/get_shorts_hashtag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/view_hashtag_posts/sections/hashtag_posts_tab_bar_section.dart';
import 'package:social_media_app/features/explore/presentation/widgets/view_hashtag_posts/sections/hashtag_posts_top_widget_section.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

class ViewHashTagPostsScreen extends StatelessWidget {
  const ViewHashTagPostsScreen(
      {super.key, required this.hashTagName, required this.hashTagPostCount});

  final String hashTagName;
  final int? hashTagPostCount;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<GetHashTagPostsCubit>()
            ..getTopHashTagPosts(hashTagName),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetShortsHashtagCubit>()
            ..getRecentHashTagPosts(hashTagName),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            addHashSymbol(hashTagName),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Center(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      if (hashTagPostCount != null)
                        HashtagPostsTopWidgetSection(
                            hashTagName: hashTagName,
                            hashTagPostCount: hashTagPostCount!)
                    ]),
                  ),
                ];
              },
              body: HashtagPostsTabBarSection(hashtagName: hashTagName),
            ),
          ),
        ),
      ),
    );
  }
}
