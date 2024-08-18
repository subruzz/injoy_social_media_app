import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';
import 'package:social_media_app/core/widgets/dialog/general_dialog_for_web.dart';
import 'package:social_media_app/features/profile/presentation/pages/username_check_page.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/ui_consts.dart';
import 'package:social_media_app/features/settings/presentation/pages/reset_password_page.dart';

import '../../../domain/entity/ui_entity/enums.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key, required this.myId});
  final String myId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppCustomAppbar(
          title: 'Account Settings',
        ),
        body: CustomAppPadding(
          child: ListView.separated(
              itemBuilder: (context, index) {
                final accountSettingItem =
                    SettingsUiConst.accountSettings[index];
                return CommonListTile(
                    trailing: accountSettingItem.trailing,
                    leading: accountSettingItem.leading,
                    onTap: () {
                      switch (accountSettingItem.accountSettingType) {
                        case AccountSettingsType.changeUserName:
                          if (isThatTabOrDeskTop) {
                            Navigator.pop(context);
                            GeneralDialogForWeb.showSideDialog(
                                context: context,
                                child: UsernameCheckPage(
                                  userid: myId,
                                  isEdit: true,
                                ));
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsernameCheckPage(
                                      userid: myId,
                                      isEdit: true,
                                    )),
                          );
                          break;
                        case AccountSettingsType.changeMail:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ChangeEmailPage()),
                          // );
                          break;
                        case AccountSettingsType.changePassword:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPasswordPage()),
                          );
                          break;
                        case AccountSettingsType.deleteAccount:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => DeleteAccountPage()),
                          // );
                          break;
                        case null:
                      }
                    },
                    text: accountSettingItem.title);
              },
              separatorBuilder: (context, index) {
                return const CustomDivider();
              },
              itemCount: SettingsUiConst.accountSettings.length),
        ));
  }
}
