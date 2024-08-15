import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';

import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
import '../../../../core/const/languages/app_languages.dart';
import '../../../../core/widgets/dialog/app_info_dialog.dart';
import '../../../../core/widgets/dialog/dialogs.dart';

class SettingsAndActivityPage extends StatelessWidget {
  const SettingsAndActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appuser = context.read<AppUserBloc>().appUser;

    return Scaffold(
      appBar: AppCustomAppbar(
        titleSize: AppLanguages.isMalayalamLocale(context) ? 16 : null,
        title: l10n!.settings_and_activity,
      ),
      body: ListView(
        children: [
          SettingsListTile(
            subSize: 11.2,
            iconSize: 27,
            asset: AppAssetsConst.accountsettings,
            text: l10n.account,
            onTap: () {
              Navigator.pushNamed(context, MyAppRouteConst.accountSettingsPage,
                  arguments: {'userId': appuser.id});
            },
            subT: l10n.change_username_delete_account,
          ),
          const CustomDivider(
            thickness: 3,
          ),
          SettingsItemHeading(text: l10n.your_library),
          SettingsListTile(
            onTap: () {
              Navigator.pushNamed(
                  context, MyAppRouteConst.likedOrSavedPostsPage,
                  arguments: {'isLiked': false});
            },
            text: l10n.saved,
            asset: AppAssetsConst.saved,
          ),
          SettingsListTile(
            onTap: () {
              Navigator.pushNamed(
                  context, MyAppRouteConst.likedOrSavedPostsPage);
            },
            text: l10n.liked,
            asset: AppAssetsConst.lovefull,
          ),
          const CustomDivider(
            thickness: 3,
          ),
          SettingsItemHeading(text: l10n.premium_features),

          SettingsListTile(
            onTap: () {
              appuser.hasPremium
                  ? Navigator.pushNamed(
                      context,
                      MyAppRouteConst.userVisitedListingRoute,
                    )
                  : AppDialogsCommon.noPremium(context);
            },
            text: l10n.seeWhoVisitedMe,
            asset: AppAssetsConst.person,
          ),
          SettingsListTile(
            text: l10n.changeAppLanguage,
            onTap: () {
              if (appuser.hasPremium) {
                showDialog(
                  context: context,
                  builder: (context) => LanguageSelectionDialog(
                      onLanguageSelected: (language) {
                      
                      }),
                );
                return;
              }
            },
            asset: AppAssetsConst.language,
          ),
          const CustomDivider(
            thickness: 3,
          ),
          SettingsItemHeading(text: l10n.settings),

          SettingsListTile(
              text: l10n.notifications,
              asset: AppAssetsConst.noti2,
              onTap: () => Navigator.pushNamed(
                  context, MyAppRouteConst.notificationSettingsPage)),
          SettingsListTile(
              text: l10n.chat,
              asset: AppAssetsConst.chat,
              onTap: () => Navigator.pushNamed(
                  context, MyAppRouteConst.chatSettingPage)),
          // SettingsTile(
          //   icon: Icons.lock,
          //   title: l10n.privacy,
          //   onTap: () {
          //     // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('myChat').
          //   },
          // ),
          // SettingsTile(icon: Icons.security, title: l10n.security),
          // SettingsTile(icon: Icons.help, title: l10n.security),
          // SettingsTile(icon: Icons.info, title: l10n.about),
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile(
      {super.key,
      this.iconSize = 25,
      required this.asset,
      required this.text,
      required this.onTap,
      this.subT,
      this.subSize});
  final String asset;
  final String text;
  final VoidCallback onTap;
  final String? subT;
  final double iconSize;
  final double? subSize;
  @override
  Widget build(BuildContext context) {
    return CommonListTile(
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
      iconSize: iconSize,
      subtitle: subT,
      text: text,
      subTitleSize: subSize,
      extraColor: Colors.white.withOpacity(.9),
      leading: asset,
      onTap: onTap,
      titileStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: AppDarkColor().primaryText),
    );
  }
}

class SettingsItemHeading extends StatelessWidget {
  const SettingsItemHeading({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700, color: AppDarkColor().primaryTextBlur),
      ),
    );
  }
}
