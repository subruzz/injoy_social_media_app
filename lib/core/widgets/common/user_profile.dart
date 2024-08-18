import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CircularUserProfile extends StatelessWidget {
  const CircularUserProfile({
    super.key,
    this.profile,
    this.size = 35,
    this.fileImg,
    this.customAsset,
    this.wantCustomAsset = false,
    this.wantSecProfile = false,
  });

  final String? profile;
  final double size;
  final File? fileImg;
  final bool wantCustomAsset;
  final bool wantSecProfile;
  final String? customAsset;

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (profile != null && profile!.isNotEmpty) {
      imageProvider = CachedNetworkImageProvider(profile!);
    } else if (fileImg != null) {
      imageProvider = FileImage(fileImg!);
    } else {
      imageProvider = AssetImage(
        wantCustomAsset
            ? customAsset ?? AppAssetsConst.profileIcon
            : wantSecProfile
                ? AppAssetsConst.userSecondaryProfile
                : AppAssetsConst.profileIcon,
      );
    }

    return CircleAvatar(
      radius: size,
      backgroundImage: imageProvider,
      backgroundColor: wantSecProfile || wantCustomAsset
          ? AppDarkColor().background
          : AppDarkColor().iconPrimaryColor,
    );
  }
}
