import 'package:flutter/material.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/personal_profile_page.dart';

class ProfilePageTopBarSection extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfilePageTopBarSection(
      {super.key, required this.userName, this.isMe = true});
  final String userName;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        addAtSymbol(userName),
        style: Theme.of(context).textTheme.displaySmall,
      ),
      actions: [
        AppSizedBox.sizedBox10W,
        if (isMe)
          CustomAppPadding(
            padding: AppPadding.onlyRightMedium,
            child: GestureDetector(
                onTap: () {
                  CustomBottomSheet.showOptions(context);
                },
                child: const CustomSvgIcon(assetPath: AppAssetsConst.moreIcon)),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
