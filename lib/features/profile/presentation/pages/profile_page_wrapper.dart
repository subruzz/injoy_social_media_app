import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/common/premium_badge.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_my_reels/get_my_reels_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/others_profile/other_user_details.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/top_bar_section/top_bar_section.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';
import 'package:social_media_app/features/settings/presentation/pages/settings_actvity_page.dart';
import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../core/theme/color/app_colors.dart';
import '../../../../core/widgets/dialog/app_info_dialog.dart';
import '../../../premium_subscription/presentation/pages/premium_subscripti_builder.dart';
import '../widgets/user_profile_page/user_profile_tab_section/user_profile_tab_section.dart';
import '../widgets/user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';

class ProfilePageWrapper extends StatefulWidget {
  const ProfilePageWrapper({super.key, this.userName, this.isMe = true});
  final String? userName;
  final bool isMe;

  @override
  State<ProfilePageWrapper> createState() => _ProfilePageWrapperState();
}

class _ProfilePageWrapperState extends State<ProfilePageWrapper> {
  late AppUser user;
  @override
  void initState() {
    user = context.read<AppUserBloc>().appUser;
    if (widget.isMe) {
      final partialUser = PartialUser(
          id: user.id,
          userName: user.userName,
          fullName: user.fullName,
          profilePic: user.profilePic);
      context
          .read<GetUserPostsBloc>()
          .add(GetUserPostsrequestedEvent(user: partialUser));
      context.read<GetMyReelsCubit>().getMyReels(partialUser);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: ProfilePageTopBarSection(
        userName: widget.userName,
        isMe: widget.userName == null,
        localization: l10n,
      ),
      body: Center(
        child: SizedBox(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        widget.isMe
                            ? Column(
                                children: [
                                  const MyProfileBasicDetails(),
                                  AppSizedBox.sizedBox15H,
                                  UserSocialActionDetailsSection(
                                    localizations: l10n,
                                    user: user,
                                  ),
                                ],
                              )
                            : OtherUserDetails(l10n: l10n)
                      ],
                    ),
                  ]))
                ];
              },
              body: UserProfileTabSection(
                appUser: user,
                isMe: widget.isMe,
                localizations: l10n!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isPremium;
  final VoidCallback onTap;
  final Color? color;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
    this.isPremium = false,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      leading: Icon(icon, color: AppDarkColor().iconSecondarycolor),
      title: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color ?? AppDarkColor().secondaryText),
            ),
          ),
          if (isPremium) AppSizedBox.sizedBox10W,
          if (isPremium) const PremiumBadge(),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomBottomSheet {
  static void showOptions(BuildContext context, AppLocalizations localization) {
    final appuser = context.read<AppUserBloc>().appUser;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: AppDarkColor().secondaryBackground,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomListTile(
                icon: Icons.settings,
                text: localization.settings,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsAndActivityPage(),
                      ));
                },
              ),
              CustomListTile(
                isPremium: true,
                icon: Icons.people_alt_outlined,
                text: localization.seeWhoVisitedMe,
                onTap: () {},
              ),
              CustomListTile(
                isPremium: true,
                icon: Icons.language,
                text: localization.changeAppLanguage,
                onTap: () {
                  AppInfoDialog.showInfoDialog(
                      title: 'Premium Feature',
                      subtitle:
                          'Unlock this feature with a premium subscription for an enhanced experience.',
                      context: context,
                      callBack: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PremiumSubscriptiBuilder(),
                            ));
                      },
                      buttonText: 'Get Premium');
                },
              ),
              if (!appuser.hasPremium)
                CustomListTile(
                  icon: Icons.star,
                  text: 'Get Premium',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PremiumSubscriptiBuilder(),
                        ));
                  },
                ),
              CustomListTile(
                color: AppDarkColor().iconSecondarycolor,
                icon: Icons.logout,
                text: localization.logOut,
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
                    title: localization.areYouSure,
                    buttonText: localization.logOut,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
