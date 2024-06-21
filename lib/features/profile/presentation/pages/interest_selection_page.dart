import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/interest_list.dart';
import 'package:social_media_app/core/widgets/app_back_button.dart';
import 'package:social_media_app/core/widgets/welcome_msg/welcome_msg.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/interest_selection/choice_chips.dart';
import 'package:social_media_app/features/profile/presentation/widgets/interest_selection/interest_empty_dialog.dart';
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
  void nextPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => LocationAskingPage(
              userProfil: widget.userProfil, profilePic: widget.profilePic)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AppBackButton()),
      floatingActionButton: NextButton(
        onpressed: () {
          if (_selectedInterests.isEmpty) {
            EmptyInterestDialog.showInterestEmptyDialog(context, nextPage);
            return;
          }
          widget.userProfil.interests = _selectedInterests;
          nextPage();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.sizedBox40H,
                const WelcomeMessage(
                    title1: 'Choose Your', title2: 'Interests'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
