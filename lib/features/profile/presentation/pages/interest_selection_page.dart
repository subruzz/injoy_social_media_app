import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/interest_list.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/choice_chips.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage(
      {super.key, required this.userProfil, this.profilePic});
  final AppUser userProfil;
  final File? profilePic;
  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  final ValueNotifier<bool> _isSelected = ValueNotifier(false);
  final List<String> _selectedInterests = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NextButton(
        onpressed: () {
          widget.userProfil.interests = _selectedInterests;
           Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LocationAskingPage(userProfil: widget.userProfil,profilePic:widget.profilePic)
              ),
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
                  children: interests.map((interest) {
                    return ValueListenableBuilder(
                      valueListenable: _isSelected,
                      builder: (context, isSelected, child) {
                        return CustomChoiceChip(
                          selected: _selectedInterests,
                          chipLabel: interest,
                          isSelected: isSelected,
                          onSelected: (value) {
                            // _isSelected.value = value;
                            // print(_selectedInterests);
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
                // if (_visibleInterestCount <
                //     interests
                //         .length) // Show expand button if there are more interests
                //   Padding(
                //     padding: const EdgeInsets.only(top: 20.0),
                //     child: TextButton(
                //       onPressed: () {
                //         setState(() {
                //           _visibleInterestCount +=
                //               10; // Show next 10 interests
                //           if (_visibleInterestCount > interests.length) {
                //             _visibleInterestCount = interests
                //                 .length; // Ensure not to exceed the total interest count
                //           }
                //         });
                //       },
                //       child: const Text(
                //         'Show More',
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
