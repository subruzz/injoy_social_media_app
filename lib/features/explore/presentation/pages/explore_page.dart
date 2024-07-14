import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import 'package:social_media_app/init_dependecies.dart';

class ExploreStartingPage extends StatelessWidget {
  const ExploreStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ExploreUserCubit>()
        ..getSuggestedUsers(
            myId: context.read<AppUserBloc>().appUser.id,
            interests: context.read<AppUserBloc>().appUser.interests),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suggested for you',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.red,
                    size: 40,
                  )
                ],
              ),
            ),
            SizedBox(
                height: 20), // Add some space between the text and the cards
            SizedBox(
              height: 220,
              child: BlocBuilder<ExploreUserCubit, ExploreUserState>(
                builder: (context, state) {
                  if (state is ExploreUsersLoaded) {
                    log('user loaded ${state.suggestedUsers}');
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.suggestedUsers.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SuggestedCard(
                            name: state.suggestedUsers[index].userName ?? '',
                            imageUrl: state.suggestedUsers[index].profilePic,
                          ),
                        );
                      },
                    );
                  }
                  return EmptyDisplay();
                },
              ),
            ),
            AppSizedBox.sizedBox20H,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'People near you',
            //       style: Theme.of(context).textTheme.titleMedium?.copyWith(
            //             color: Colors.white,
            //           ),
            //     ),
            //     const Icon(
            //       Icons.keyboard_double_arrow_right,
            //       color: Colors.red,
            //       size: 40,
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 220,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: suggestions.length,
            //     shrinkWrap: true, 
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: SuggestedCard(
            //           name: suggestions[index]['name']!,
            //           imageUrl: suggestions[index]['image']!,
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}

class SuggestedCard extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const SuggestedCard({
    Key? key,
    required this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: imageUrl == null
                  ? Image.asset(AppAssetsConst.userSecondaryProfile)
                  : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
