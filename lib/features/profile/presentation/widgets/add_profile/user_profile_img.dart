import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/edit_profile.dart';

import '../../../../../core/services/assets/asset_services.dart';
import '../../../../../core/widgets/common/user_profile.dart';

class UserProfileImg extends StatelessWidget {
  const UserProfileImg({super.key, required this.userProfile, this.profilePic});
  final ValueNotifier<File?> userProfile;
  final String? profilePic;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: userProfile,
          builder: (context, value, child) {
            return CircularUserProfile(
              size: 70,
              fileImg: value,
              profile: value == null ? profilePic : null,
            );
          },
        ),
        // Positioned(
        //   right: 10.r,
        //   top: 10,
        //   child: GestureDetector(
        //       onTap: () {},
        //       child: const Icon(
        //         Icons.close,
        //         size: 17,
        //       )),
        // ),
        Positioned(
          right: isThatMobile ? 20.r : 20,
          bottom: 0,
          child: GestureDetector(
              onTap: () async {
                final img = await AssetServices.pickOneImage();
                if (img == null) return;
                userProfile.value = img;
              },
              child: const EditProfileIcon()),
        ),
      ],
    );
  }
}
