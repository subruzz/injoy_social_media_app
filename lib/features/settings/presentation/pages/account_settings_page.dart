import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/utils/routes/page_transitions.dart';
import 'package:social_media_app/core/widgets/common/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';
import 'package:social_media_app/features/profile/presentation/pages/username_check_page.dart';
import 'package:social_media_app/features/settings/presentation/pages/settings_actvity_page.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key, required this.myId});
  final String myId;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppCustomAppbar(
          title: l10n!.account_settings,
        ),
        body: CustomAppPadding(
            child: ListView(
          children: [
                       
            const CustomDivider(
              thickness: 3,
            ),
            SettingsListTile(
                iconSize: 22,
                asset: AppAssetsConst.delete,
                text: l10n.delete_account,
                onTap: () {})
          ],
        )));
  }
}
// ListView.separated(
              // itemBuilder: (context, index) {
              //   final accountSettingItem =
              //       SettingsUiConst.accountSettings[index];
              //   return CommonListTile(
              //       trailing: accountSettingItem.trailing,
              //       leading: accountSettingItem.leading,
              //       onTap: () {
              //         switch (accountSettingItem.accountSettingType) {
              //           case AccountSettingsType.changeUserName:
              //             if (isThatTabOrDeskTop) {
              //               Navigator.pop(context);
              //               GeneralDialogForWeb.showSideDialog(
              //                   context: context,
              //                   child: UsernameCheckPage(
              //                     userid: myId,
              //                     isEdit: true,
              //                   ));
              //               return;
              //             }
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => UsernameCheckPage(
              //                         userid: myId,
              //                         isEdit: true,
              //                       )),
              //             );
              //             break;
              //           case AccountSettingsType.changeMail:
              //             // Navigator.push(
              //             //   context,
              //             //   MaterialPageRoute(
              //             //       builder: (context) => ChangeEmailPage()),
              //             // );
              //             break;
              //           case AccountSettingsType.changePassword:
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => ResetPasswordPage()),
              //             );
              //             break;
              //           case AccountSettingsType.deleteAccount:
              //             // Navigator.push(
              //             //   context,
              //             //   MaterialPageRoute(
              //             //       builder: (context) => DeleteAccountPage()),
              //             // );
              //             break;
              //           case null:
              //         }
              //       },
              //       text: accountSettingItem.title);
              // },
              // separatorBuilder: (context, index) {
              //   return const CustomDivider();
              // },
              // itemCount: SettingsUiConst.accountSettings.length),