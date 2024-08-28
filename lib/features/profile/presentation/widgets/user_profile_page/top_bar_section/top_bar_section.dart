import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/features/settings/presentation/pages/settings_actvity_page.dart';

import '../../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../../../core/const/app_config/app_padding.dart';
import '../../../../../../core/const/assets/app_assets.dart';
import '../../../../../../core/theme/color/app_colors.dart';
import '../../../../../../core/utils/routes/tranistions/app_routes_const.dart';
import '../../../../../../core/widgets/app_related/app_padding.dart';
import '../../../../../../core/widgets/app_related/app_svg.dart';
import '../../../../../../core/widgets/dialog/general_dialog_for_web.dart';
import '../../../pages/edit_profile_page.dart';

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
          ? Text(addAtSymbol(userName ?? ''),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: isThatTabOrDeskTop ? 11 : null,
                  ))
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
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: isThatTabOrDeskTop ? 22 : null,
                      ),
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
                if (isThatTabOrDeskTop) {
                  GeneralDialogForWeb.showSideDialog(
                      context: context, child: const EditProfilePage());
                  return;
                }
                Navigator.pushNamed(context, MyAppRouteConst.editProfilePage);
              },
              assetPath: AppAssetsConst.edit),
        AppSizedBox.sizedBox20W,
        if (isMe)
          CustomAppPadding(
            padding: AppPadding.onlyRightMedium,
            child: GestureDetector(
                onTap: () {
                  if (isThatTabOrDeskTop) {
                    return GeneralDialogForWeb.showSideDialog(
                        context: context,
                        child: const SettingsAndActivityPage());
                  }
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
