import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/common/partial_user_widget.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/bloc/who_visited/who_visited_bloc.dart';

import '../../../../core/utils/di/di.dart';

class UserVisitedListingPage extends StatelessWidget {
  const UserVisitedListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<WhoVisitedBloc>()
        ..add(GetAllVisitedUser(myId: context.read<AppUserBloc>().appUser.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Visited Me',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: BlocConsumer<WhoVisitedBloc, WhoVisitedState>(
          builder: (context, state) {
            if (state is GetVisitedUserSuccess) {
              if (state.visitedUsers.isEmpty) {
                return const Center(
                  child: Text("No visited Found!"),
                );
              }
              final categorizedVisits = categorizeVisits(state.visitedUsers);
              return ListView(
                padding: AppPadding.medium,
                children: [
                  if (categorizedVisits.todayVisits.isNotEmpty)
                    _buildCategorySection(
                        'Today', categorizedVisits.todayVisits, context),
                  if (categorizedVisits.lastWeekVisits.isNotEmpty)
                    _buildCategorySection(
                        'This Week', categorizedVisits.lastWeekVisits, context),
                  if (categorizedVisits.lastMonthVisits.isNotEmpty)
                    _buildCategorySection('This Month',
                        categorizedVisits.lastMonthVisits, context),
                  if (categorizedVisits.olderVisits.isNotEmpty)
                    _buildCategorySection(
                        'Older', categorizedVisits.olderVisits, context),
                ],
              );
            }
            if (state is GetVisitedUserError) {
              return const Center(
                child: AppErrorGif(),
              );
            }
            return const Center(
              child: CircularLoadingGrey(),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      String title, List<UserVisit> visits, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ...visits.map((visit) => PartialUserWidget(user: visit.user)),
      ],
    );
  }
}
