import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/app_related/policies.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';
import 'package:social_media_app/core/widgets/common/overlay_loading_holder.dart';
import 'package:social_media_app/core/widgets/common/premium_badge.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/ai_chat/presentation/cubits/cubit/ai_chat_cubit.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';
import 'package:social_media_app/features/settings/presentation/pages/chat_settings_page.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/pages/user_visited_listing_page.dart';
import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/const/languages/app_languages.dart';
import '../../../../core/utils/app_related/open_email.dart';
import '../../../../core/utils/responsive/constants.dart';
import '../../../../core/utils/routes/page_transitions.dart';
import '../../../../core/widgets/dialog/app_info_dialog.dart';
import '../../../../core/widgets/dialog/dialogs.dart';
import '../../../../core/widgets/dialog/general_dialog_for_web.dart';
import '../../../profile/presentation/pages/username_check_page.dart';

class SettingsAndActivityPage extends StatelessWidget {
  const SettingsAndActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n!;
    final appuser = context.read<AppUserBloc>().appUser;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          Messenger.showSnackBar(message: l10n.logoutError);
        }
        if (state is AuthNotLoggedIn) {
          context.read<AiChatCubit>().init();
          context.read<AppLanguageCubit>().setInitial();
          context.read<ChatWallapaperCubit>().init();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppCustomAppbar(
                titleSize: AppLanguages.isMalayalamLocale(context) ? 16 : null,
                title: l10n.settings_and_activity,
              ),
              body: ListView(
                children: [
                  SettingsListTile(
                      iconSize: 24,
                      asset: AppAssetsConst.person,
                      text: l10n.change_username,
                      onTap: () {
                        if (isThatTabOrDeskTop) {
                          return GeneralDialogForWeb.showSideDialog(
                              context: context,
                              child: UsernameCheckPage(
                                userid: appuser.id,
                                isEdit: true,
                              ));
                        }
                        Navigator.push(
                          context,
                          AppPageTransitions.rightToLeft(
                            UsernameCheckPage(
                              userid: appuser.id,
                              isEdit: true,
                            ),
                          ),
                        );
                      }),
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
                  if (isThatMobile)
                    SettingsListTile(
                      onTap: () {
                        appuser.hasPremium
                            ? Navigator.pushNamed(context,
                                MyAppRouteConst.premiumSubscriptionDetailsPage)
                            : Navigator.pushNamed(
                                context, MyAppRouteConst.premiumPage);
                      },
                      text: appuser.hasPremium
                          ? l10n.subscription_details
                          : l10n.getPremium,
                      asset: AppAssetsConst.premium,
                    ),
                  SettingsListTile(
                    onTap: () {
                      appuser.hasPremium
                          ? isThatTabOrDeskTop
                              ? GeneralDialogForWeb.showSideDialog(
                                  context: context,
                                  child: const UserVisitedListingPage())
                              : Navigator.pushNamed(
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
                  if (isThatMobile)
                    SettingsListTile(
                        text: l10n.notifications,
                        asset: AppAssetsConst.noti2,
                        onTap: () => Navigator.pushNamed(
                            context, MyAppRouteConst.notificationSettingsPage)),
                  SettingsListTile(
                      text: l10n.chat,
                      asset: AppAssetsConst.chat,
                      onTap: () => isThatTabOrDeskTop
                          ? GeneralDialogForWeb.showSideDialog(
                              context: context, child: const ChatSettingsPage())
                          : Navigator.pushNamed(
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
                  CommonListTile(
                    text: l10n.logOut,
                    extraColor: AppDarkColor().buttonBackground,
                    iconSize: 27,
                    leading: AppAssetsConst.logout,
                    showTrail: false,
                    onTap: () {
                      AppInfoDialog.showInfoDialog(
                        title: l10n.areYouSure,
                        context: context,
                        buttonText: l10n.logOut,
                        callBack: () {
                          context.read<AuthBloc>().add(LogoutUser(
                              uId: context.read<AppUserBloc>().appUser.id));
                        },
                      );
                    },
                  ),
                  // CustomListTile(
                  //   color: AppDarkColor().buttonBackground,
                  //   icon: Icons.logout,
                  //   text: l10n.logOut,
                  //   onTap: () {
                  //     AppInfoDialog.showInfoDialog(
                  //       context: context,
                  //       callBack: () {
                  //         FirebaseAuth.instance.signOut().then((value) async {
                  //           if (context.mounted) {
                  //             Navigator.pushAndRemoveUntil(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => const LoginPage(),
                  //               ),
                  //               (route) => false,
                  //             );
                  //           }
                  //         }).catchError((error) {});
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
            if (state is AuthLoading) const OverlayLoadingHolder()
          ],
        );
      },
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
