import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/app_related/policies.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';
import 'package:social_media_app/core/widgets/common/premium_badge.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';

import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/const/languages/app_languages.dart';
import '../../../../core/utils/app_related/open_email.dart';
import '../../../../core/widgets/dialog/app_info_dialog.dart';
import '../../../../core/widgets/dialog/dialogs.dart';
import '../../../premium_subscription/presentation/pages/premium_subscripti_builder.dart';
import '../../../profile/presentation/pages/profile_page_wrapper.dart';

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
            subSize: 12,
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
          SettingsItemHeading(
            text: l10n.premium_features,
            isItPremium: true,
          ),
          SettingsListTile(
            onTap: () {
              !appuser.hasPremium
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumSubscriptiBuilder(),
                      ))
                  : () {};
              // appuser.hasPremium
              //     ? Navigator.pushNamed(
              //         context,
              //         MyAppRouteConst.userVisitedListingRoute,
              //       )
              //     : AppDialogsCommon.noPremium(context);
            },
            text: appuser.hasPremium
                ? l10n.subscription_details
                : l10n.getPremium,
            asset: AppAssetsConst.premium,
          ),
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
            iconSize: 26,
            text: l10n.changeAppLanguage,
            onTap: () {
              if (appuser.hasPremium) {
                showDialog(
                  context: context,
                  builder: (context) => LanguageSelectionDialog(
                      onLanguageSelected: (language) {}),
                );
                return;
              }
              AppDialogsCommon.noPremium(context);
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
          const CustomDivider(
            thickness: 3,
          ),
          SettingsItemHeading(text: l10n.more_info_and_support),
          SettingsListTile(
              iconSize: 23,
              text: l10n.help,
              asset: AppAssetsConst.help,
              onTap: EmailService.openGmail),
          SettingsListTile(
              iconSize: 23,
              text: l10n.privacy_center,
              asset: AppAssetsConst.privacy,
              onTap: AppPolicies.goToPrivacyPolicies),
          SettingsListTile(
              iconSize: 23,
              text: l10n.terms_and_conditions,
              asset: AppAssetsConst.terms,
              onTap: AppPolicies.goToTermsAndConditions),
          const CustomDivider(
            thickness: 3,
          ),
          CustomListTile(
            color: AppDarkColor().iconSecondarycolor,
            icon: Icons.logout,
            text: l10n.logOut,
            onTap: () {
              AppInfoDialog.showInfoDialog(
                context: context,
                callBack: () {
                  FirebaseAuth.instance.signOut().then((value) async {
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    }
                  }).catchError((error) {});
                },
              );
            },
          ),
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
  const SettingsItemHeading(
      {super.key, this.isItPremium = false, required this.text});
  final String text;
  final bool isItPremium;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppDarkColor().primaryTextBlur),
          ),
          if (isItPremium) AppSizedBox.sizedBox10W,
          if (isItPremium) const PremiumBadge()
        ],
      ),
    );
  }
}
