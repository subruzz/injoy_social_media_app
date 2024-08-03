import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_user/search_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/explore_search_loading.dart';
import 'package:social_media_app/core/partial_user_widget.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/search_empty_error_text.dart';

class UserSearchTab extends StatelessWidget {
  const UserSearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchUserCubit, SearchUserState>(
      //change to bloc builder
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchUserSuccess) {
          if (state.searchedUsers.isEmpty) {
            return ExploreFieldMessages(query: state.query);
          }
          return ListView.builder(
            padding: AppPadding.small,
            itemCount: state.searchedUsers.length,
            itemBuilder: (context, index) {
              return PartialUserWidget(user: state.searchedUsers[index]);
            },
          );
        }
        if (state is SearchUserFailure) {
          return const ExploreFieldMessages(
            isError: true,
          );
        }
        return const ExploreSearchLoading();
      },
    );
  }
}
