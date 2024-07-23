import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/explore_search_loading.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/search_empty_error_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/tag_location_item.dart';

import '../../../../blocs/search_hash_tag/search_hash_tag_cubit.dart';

class HashtagSearchTab extends StatelessWidget {
  const HashtagSearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchHashTagCubit, SearchHashTagState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchHashTagSuccess) {
          if (state.searchedHashtags.isEmpty) {
            return ExploreFieldMessages(query: state.query);
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            itemCount: state.searchedHashtags.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MyAppRouteConst.hashtagPostsRoute,
                    arguments: {
                      'hashTagName': state.searchedHashtags[index].hashtagName,
                      'hashTagPostCount': state.searchedHashtags[index].count,
                    },
                  );
                },
                child: TagLocationItem(
                  title:
                      addHashSymbol(state.searchedHashtags[index].hashtagName),
                  postCount: state.searchedHashtags[index].count,
                ),
              );
            },
          );
        }
        if (state is SearchHashTagFailure) {
          return const ExploreFieldMessages(
            isError: true,
          );
        }
        return const ExploreSearchLoading();
      },
    );
  }
}
