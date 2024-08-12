import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/partial_user_widget.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/bloc/who_visited/who_visited_bloc.dart';

class UserVisitedListingPage extends StatefulWidget {
  const UserVisitedListingPage({super.key});

  @override
  State<UserVisitedListingPage> createState() => _UserVisitedListingPageState();
}

class _UserVisitedListingPageState extends State<UserVisitedListingPage> {
  @override
  void initState() {
    log('called who visited');
    super.initState();
    context
        .read<WhoVisitedBloc>()
        .add(GetAllVisitedUser(myId: context.read<AppUserBloc>().appUser.id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _buildCategorySection('Today', categorizedVisits.todayVisits),
                if (categorizedVisits.lastWeekVisits.isNotEmpty)
                  _buildCategorySection(
                      'This Week', categorizedVisits.lastWeekVisits),
                if (categorizedVisits.lastMonthVisits.isNotEmpty)
                  _buildCategorySection(
                      'This Month', categorizedVisits.lastMonthVisits),
                if (categorizedVisits.olderVisits.isNotEmpty)
                  _buildCategorySection('Older', categorizedVisits.olderVisits),
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
    );
  }

  Widget _buildCategorySection(String title, List<UserVisit> visits) {
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
