import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_location_explore/search_location_explore_cubit.dart';
import 'package:social_media_app/features/explore/presentation/pages/location_post_view.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/explore_search_loading.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/search_empty_error_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/tag_location_item.dart';

class LocationSearchTab extends StatelessWidget {
  const LocationSearchTab({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchLocationExploreCubit, SearchLocationExploreState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchLocationSuccess) {
          if (state.searchedLocations.isEmpty) {
            return ExploreFieldMessages(query: state.query);
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            itemCount: state.searchedLocations.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocationPostView(
                      location: state.searchedLocations[index].locationName,
                      locationCount: state.searchedLocations[index].count,
                    ),
                  ));
                },
                child: TagLocationItem(
                  isLocation: true,
                  title: state.searchedLocations[index].locationName,
                  postCount: state.searchedLocations[index].count,
                ),
              );
            },
          );
        }
        if (state is SearchLocationFailure) {
          return const ExploreFieldMessages(
            isError: true,
          );
        }
        return const ExploreSearchLoading();
      },
    );
  }
}
