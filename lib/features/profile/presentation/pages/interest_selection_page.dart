import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/interest_list.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/pages/location_asking_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/choice_chips.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage(
      {super.key, required this.userProfil, this.profilePic});
  final UserProfile userProfil;
  final File? profilePic;
  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

final List<String> selectedInterests = ['hola', 'mama  mia'];

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  int _visibleInterestCount = 10; // Initially, show 10 interests

  @override
  Widget build(BuildContext context) {
    print(widget.profilePic);

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileInterestsSet) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationAskingPage(
                userProfil: state.userProfile,
                profilePic: widget.profilePic,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        floatingActionButton: NextButton(
          onpressed: () {
            context.read<ProfileBloc>().add(
                  ProfileSetUpInterestsEvent(
                      interests: selectedInterests,
                      userProfile: widget.userProfil),
                );
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  AppSizedBox.sizedBox40H,
                  Text(
                    'Choose Your',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(letterSpacing: 2.0),
                  ),
                  AppSizedBox.sizedBox5H,
                  Text(
                    'Interests',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(letterSpacing: 2.0),
                  ),
                  AppSizedBox.sizedBox20H,
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children:
                        interests.take(_visibleInterestCount).map((interest) {
                      return CustomChoiceChip(
                        chipLabel: interest,
                        isSelected: false,
                        onSelected: (value) {},
                      );
                    }).toList(),
                  ),
                  if (_visibleInterestCount <
                      interests
                          .length) // Show expand button if there are more interests
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _visibleInterestCount +=
                                10; // Show next 10 interests
                            if (_visibleInterestCount > interests.length) {
                              _visibleInterestCount = interests
                                  .length; // Ensure not to exceed the total interest count
                            }
                          });
                        },
                        child: const Text(
                          'Show More',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
