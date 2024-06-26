import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/location/presentation/widgets/popup.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';

class LocationAskingPage extends StatelessWidget {
  const LocationAskingPage(
      {super.key, required this.userProfil, this.profilePic});
  final AppUser userProfil;
  final File? profilePic;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSubmissionSuccess) {
          final user = context.read<AppUserBloc>().appUser!;
          context
              .read<FollowingPostFeedBloc>()
              .add(FollowingPostFeedGetEvent(uId: user.id));
          context
              .read<GetUserPostsBloc>()
              .add(GetUserPostsrequestedEvent(uid: user.id));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottonNavWithAnimatedIcons(),
              ));
        }
        if (state is ProfileSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('failure'),
              duration: Duration(seconds: 2), // Adjust the duration as needed
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileSetUpLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Skip',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      )
                    ],
                  ),
                  AppSizedBox.sizedBox15H,
                  TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // _debouncer.run(
                      //   () => locationBloc.add(
                      //     SearchLocationsEvent(query: value),
                      //   ),
                      // );
                    },
                    // autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    // cursorColor: AppDarkColor().primaryText,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      filled: true,
                      fillColor: AppDarkColor().fillColor,
                      hintText: 'Search Manually...',
                      // hintStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Center(
                    child: Lottie.asset('assets/images/location_lottie.json',
                        fit: BoxFit.cover, width: double.infinity),
                  ),
                  const Text(
                      textAlign: TextAlign.center,
                      'We need your location to enhance your experience by providing personalized services and recommendations. Your location data will be kept confidential and secure'),
                  const Spacer(),
                  BlocConsumer<LocationBloc, LocationState>(
                    listener: (context, state) {
                      if (state is LocationSuccess) {
                        showDialog(
                          context: context,
                          builder: (context) => LocationPopup(
                            currentLocation: state
                                .locationName, // Replace with your current location
                            onSave: () {
                              userProfil.location = state.locationName;
                              userProfil.latitude = state.latitue;
                              userProfil.longitude = state.longitude;
                              context.read<ProfileBloc>().add(
                                  ProfileSetUpLocationEvent(
                                      userProfile: userProfil,
                                      profilePic: profilePic));
                            },
                          ),
                        );
                      }
                      if (state is LocationNotOnState) {
                        Messenger.showSnackBar(
                            message: 'please turn on location on your phone');
                      }
                    },
                    builder: (context, state) {
                      if (state is LocationLoading) {
                        return CircularProgressIndicator();
                      }
                      return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<LocationBloc>()
                                .add(LocationCurrentEvent());
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Allow',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
