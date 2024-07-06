import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CircularUserProfile extends StatelessWidget {
  const CircularUserProfile({super.key, this.profile, this.size = 35,this.fileImg});
  final String? profile;
  final double size;
  final File? fileImg;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: size.w,
        backgroundImage: profile != null
            ? CachedNetworkImageProvider(
                profile!,
              ):fileImg!=null?FileImage(fileImg!)
            : const AssetImage(
                AppAssetsConst.profileIcon,
              ) as ImageProvider,
        backgroundColor: AppDarkColor().iconPrimaryColor);
  }
}
