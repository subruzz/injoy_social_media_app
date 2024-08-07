import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/common_list_tile.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile/username_check_page.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/ui_consts.dart';
import 'package:social_media_app/features/settings/presentation/pages/reset_password_page.dart';

import '../../../domain/entity/ui_entity/enums.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key, required this.appUser});
  final AppUser appUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Account Settings',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsernameCheckPage(
                                      userid: appUser.id,
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
