import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/features/explore/presentation/blocs/follow_hashtag/follow_hashtag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_hash_tag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recent_hashtag_posts/get_recent_hashtag_posts_cubit.dart';
import 'package:social_media_app/init_dependecies.dart';

class ViewHashTagPostsScreen extends StatefulWidget {
  const ViewHashTagPostsScreen(
      {super.key, required this.hashTagName, required this.hashTagPostCount});

  final String hashTagName;
  final int hashTagPostCount;

  @override
  _ViewHashTagPostsScreenState createState() => _ViewHashTagPostsScreenState();
}

class _ViewHashTagPostsScreenState extends State<ViewHashTagPostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FollowHashtagCubit>().checkIfFollowing(widget.hashTagName);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<GetHashTagPostsCubit>()
            ..getTopHashTagPosts(widget.hashTagName),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetRecentHashtagPostsCubit>()
            ..getRecentHashTagPosts(widget.hashTagName),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(addHashSymbol(widget.hashTagName)),
        ),
        body: Center(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      CustomAppPadding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.pink,
                                    radius: 35,
                                    child: Text(
                                      '#',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSizedBox.sizedBox5H,
                            Text(addHashSymbol(widget.hashTagName)),
                            Text('${widget.hashTagPostCount.toString()} posts'),
                            AppSizedBox.sizedBox5H,
                            BlocBuilder<FollowHashtagCubit, FollowHashtagState>(
                              builder: (context, state) {
                                if (state is FollowHashtagLoading) {
                                  return CircularProgressIndicator();
                                } else if (state is FollowHashtagFailure) {
                                  return Column(
                                    children: [
                                      CustomButton(
                                        height: 40,
                                        onClick: () {
                                          state is FollowHashtagFollowing
                                              ? context
                                                  .read<FollowHashtagCubit>()
                                                  .unfollowHashtag(
                                                      widget.hashTagName)
                                              : context
                                                  .read<FollowHashtagCubit>()
                                                  .followHashtag(
                                                      widget.hashTagName);
                                        },
                                        radius: AppBorderRadius.extraLarge,
                                        child: Text(
                                            state is FollowHashtagFollowing
                                                ? 'Following'
                                                : 'Follow'),
                                      ),
                                      SizedBox(height: 10),
                                      Text('Error: ${state.error}',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  );
                                }
                                return CustomButton(
                                  height: 40,
                                  onClick: () {
                                    state is FollowHashtagFollowing
                                        ? context
                                            .read<FollowHashtagCubit>()
                                            .unfollowHashtag(widget.hashTagName)
                                        : context
                                            .read<FollowHashtagCubit>()
                                            .followHashtag(widget.hashTagName);
                                  },
                                  radius: AppBorderRadius.extraLarge,
                                  child: Text(state is FollowHashtagFollowing
                                      ? 'Following'
                                      : 'Follow'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ];
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSizedBox.sizedBox15H,
                  TabBar(
                    dividerColor: AppDarkColor().secondaryBackground,
                    indicatorColor: AppDarkColor().iconSecondarycolor,
                    tabs: const [
                      Text('Top'),
                      Text('Recent'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        BlocBuilder<GetHashTagPostsCubit, GetHashTagPostsState>(
                          builder: (context, state) {
                            if (state is GetHashTagTopPostSucess) {
                              return MasonryGridView.builder(
                                itemCount: state.hashTagTopPosts.length,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) =>
                                    CachedNetworkImage(
                                  imageUrl: state.hashTagTopPosts[index]
                                      .postImageUrl.first,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              );
                            }
                            return EmptyDisplay();
                          },
                        ),
                        BlocBuilder<GetRecentHashtagPostsCubit,
                            GetRecentHashtagPostsState>(
                          builder: (context, state) {
                            if (state is GetHashTagRecentPostSucess) {
                              return MasonryGridView.builder(
                                itemCount: state.hashTagRecentPosts.length,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) =>
                                    CachedNetworkImage(
                                  imageUrl: state.hashTagRecentPosts[index]
                                      .postImageUrl.first,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              );
                            }
                            return EmptyDisplay();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
