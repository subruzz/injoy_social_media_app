import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/partial_user_widget.dart';
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
    super.initState();
    context.read<WhoVisitedBloc>().add(GetAllVisitedUser(myId: context.read<AppUserBloc>().appUser.id));
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
            final categorizedVisits = categorizeVisits(state.visitedUsers);
            return ListView(
              padding: AppPadding.medium,
              children: [
                if (categorizedVisits.todayVisits.isNotEmpty)
                  _buildCategorySection('Today', categorizedVisits.todayVisits),
                if (categorizedVisits.lastWeekVisits.isNotEmpty)
                  _buildCategorySection('This Week', categorizedVisits.lastWeekVisits),
                if (categorizedVisits.lastMonthVisits.isNotEmpty)
                  _buildCategorySection('This Month', categorizedVisits.lastMonthVisits),
                if (categorizedVisits.olderVisits.isNotEmpty)
                  _buildCategorySection('Older', categorizedVisits.olderVisits),
              ],
            );
          }
          return const EmptyDisplay();
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
        ...visits.map((visit) => PartialUserWidget(user: visit.user)).toList(),
      ],
    );
  }
}
