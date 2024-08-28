import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_tag_or_location_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_shorts_of_tag_or_location/get_shorts_hashtag_or_location_cubit.dart';
import 'package:social_media_app/features/explore/presentation/pages/custom_map_design.dart';
import 'package:social_media_app/features/explore/presentation/widgets/tag_or_location_posts/sections/hashtag_posts_tab_bar_section.dart';
import 'package:social_media_app/features/explore/presentation/widgets/tag_or_location_posts/sections/hashtag_posts_top_widget_section.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

import '../../../../core/utils/app_related/open_map.dart';
import '../../../../core/widgets/messenger/messenger.dart';

class ViewTagOrLocationPosts extends StatelessWidget {
  const ViewTagOrLocationPosts(
      {super.key,
      required this.tagOrLocation,
      this.isLoc = false,
      required this.postCount,
      this.loc});

  final String tagOrLocation;
  final int? postCount;
  final bool isLoc;
  final ExploreLocationSearchEntity? loc;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<GetTagOrLocationPostsCubit>()
            ..getTagOrLocationPosts(tagOrLocation, isLoc),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetShortsHashtagOrLocationCubit>()
            ..getShortsHashTagPosts(tagOrLocation, isLoc),
        ),
      ],
      child: Scaffold(
        appBar: AppCustomAppbar(
          title: isLoc ? tagOrLocation : addHashSymbol(tagOrLocation),
        ),
        body: Center(
          child: WebWidthHelper(
            width: 600,
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (_, __) {
                  return [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        if (postCount != null)
                          HashtagPostsTopWidgetSection(
                              isLoc: isLoc,
                              tagOrLocation: tagOrLocation,
                              postCount: postCount!),
                        if (loc != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                                radius: AppBorderRadius.extraLarge,
                                height: 45,
                                child: const CustomText(
                                  text: 'More Information',
                                  fontWeight: FontWeight.w600,
                                ),
                                onClick: () {
                                  if (loc!.latitude == null ||
                                      loc!.longitude == null) {
                                    Messenger.showSnackBar(
                                        message:
                                            'We are sorry , unable to open map right now !');
                                    return;
                                  }
                                  MapService.openMap(
                                      latitude: loc!.latitude!,
                                      longitude: loc!.longitude!);
                                }),
                          )
                      ]),
                    ),
                  ];
                },
                body: HashtagPostsTabBarSection(tagOrLocation: tagOrLocation),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
