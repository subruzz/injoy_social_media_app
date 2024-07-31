import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/explore_main_card_shimmer.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/explore_welcome_msg.dart';
import 'package:social_media_app/init_dependecies.dart';
import '../widgets/explore_main_page/common_widgets/explore_user_card.dart';

class ExploreWelcomScreen extends StatefulWidget {
  const ExploreWelcomScreen({super.key});

  @override
  State<ExploreWelcomScreen> createState() => _ExploreWelcomScreenState();
}

class _ExploreWelcomScreenState extends State<ExploreWelcomScreen> {
  final PageController pageController = PageController(viewportFraction: 0.8);
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (context) {
          final user = context.read<AppUserBloc>().appUser;

          return serviceLocator<ExploreUserCubit>()
            ..getNearAndInteretsMatchingUsers(
                interests: user.interests,
                myId: user.id,
                following: user.following,
                latitude: user.latitude,
                longitude: user.longitude);
        },
        child: BlocBuilder<ExploreUserCubit, ExploreUserState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSizedBox.sizedBox15H,
                    if (state is ExploreUsersLoading)
                      ExploreMainCardShimmer(controller: pageController),
                    if (state is ExploreUsersLoaded &&
                        state.suggestedUsers.isEmpty)
                      const ExploreWelcomeMsg(),
                    if (state is ExploreUsersLoaded &&
                        state.suggestedUsers.isNotEmpty)
                      Expanded(
                        child: PageView.builder(
                          onPageChanged: (index) {
                            _indexNotifier.value = index;
                          },
                          physics: const BouncingScrollPhysics(),
                          controller: pageController,
                          itemCount: state.suggestedUsers.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: UserCard(
                                index: index,
                                user: state.suggestedUsers[index],
                                isActive: _indexNotifier,
                              ),
                            );
                          },
                        ),
                      )
                  ]),
            );
          },
        ),
      ),
    );
  }
}
