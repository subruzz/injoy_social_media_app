import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import '../../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../pages/edit_profile_page.dart';
import '../../../pages/profile_page_wrapper.dart';

class ProfilePageTopBarSection extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfilePageTopBarSection(
      {super.key, this.userName, this.isMe = true, this.localization});
  final String? userName;
  final bool isMe;
  final AppLocalizations? localization;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: userName != null
          ? Text(
              addAtSymbol(userName ?? ''),
              style: Theme.of(context).textTheme.displaySmall,
            )
          : BlocBuilder<AppUserBloc, AppUserState>(
              buildWhen: (previous, current) {
                if (previous is AppUserLoggedIn && current is AppUserLoggedIn) {
                  return (previous.user.userName != current.user.userName);
                }
                return false;
              },
              builder: (context, state) {
                return Text(
                  addAtSymbol(state.currentUser?.userName),
                  style: Theme.of(context).textTheme.displaySmall,
                );
              },
            ),
      actions: [
        AppSizedBox.sizedBox10W,
        if (isMe)
          CustomSvgIcon(
              color: AppDarkColor().iconPrimaryColor,
              height: 21,
              width: 21,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ));
              },
              assetPath: AppAssetsConst.edit),
        AppSizedBox.sizedBox20W,
        if (isMe)
          CustomAppPadding(
            padding: AppPadding.onlyRightMedium,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, MyAppRouteConst.settingAndActivityPage);
                },
                child: CustomSvgIcon(
                  assetPath: AppAssetsConst.menu,
                  height: 29,
                  color: AppDarkColor().iconPrimaryColor,
                )),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
