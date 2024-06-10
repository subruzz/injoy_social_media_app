import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/features/home.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';

class LocationAskingPage extends StatelessWidget {
  const LocationAskingPage(
      {super.key, required this.userProfil, this.profilePic});
  final UserProfile userProfil;
  final File? profilePic;
  @override
  Widget build(BuildContext context) {
    print(profilePic);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSubmissionSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomsCreen(),
              ));
        }
        if (state is ProfileSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('failure mother fuckeer'),
              duration: Duration(seconds: 2), // Adjust the duration as needed
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                  Center(
                    child: Lottie.asset('assets/images/location_lottie.json',
                        fit: BoxFit.cover, width: double.infinity),
                  ),
                  const Text(
                      textAlign: TextAlign.center,
                      'We need your location to enhance your experience by providing personalized services and recommendations. Your location data will be kept confidential and secure'),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                              ProfileSetUpLocationEvent(
                                  latitude: 6735434,
                                  longitude: 354345,
                                  location: 'kea3453453ra',
                                  userProfile: userProfil,
                                  profilePic: profilePic),
                            );
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
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
