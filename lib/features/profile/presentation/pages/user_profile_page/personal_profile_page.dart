import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

import 'package:social_media_app/features/profile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/top_bar_section/top_bar_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_profile_tab_section/user_profile_tab_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';

import '../../../../../core/const/app_info_dialog.dart';
import '../../../../../core/routes/app_routes_const.dart';
import '../../../../../core/shared_providers/blocs/app_user/app_user_bloc.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserBloc>().appUser;

    return Scaffold(
      appBar: ProfilePageTopBarSection(
        userName: user.userName ?? '',
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
                        UserBasicDetailSection(user: user),
                        AppSizedBox.sizedBox15H,
                        UserSocialActionDetailsSection(
                          user: user,
                        ),
                      ],
                    ),
                  ]))
                ];
              },
              body: const UserProfileTabSection(),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomSheet {
  static void showOptions(BuildContext context) {
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
              _buildListTile(
                icon: Icons.settings,
                text: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                  // Add your onTap code here
                },
              ),
              _buildListTile(
                icon: Icons.person,
                text: 'Edit Profile',
                onTap: () {
                  Navigator.pop(context);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                        appUser: context.read<AppUserBloc>().appUser),
                  ));
                },
              ),
              _buildListTile(
                icon: Icons.interests,
                text: 'Edit Interests',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    MyAppRouteConst.interestSelectRoute,
                    arguments: context.read<AppUserBloc>().appUser.interests,
                  );
                },
              ),
              _buildListTile(
                icon: Icons.star,
                text: 'Get Premium',
                onTap: () {
                  Navigator.pop(context);
                  // Add your onTap code here
                },
              ),

              // _buildListTile(
              //   icon: Icons.qr_code,
              //   text: 'QR Code',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Add your onTap code here
              //   },
              // ),

              // _buildListTile(
              //   icon: Icons.people,
              //   text: 'Close Friends',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Add your onTap code here
              //   },
              // ),

              _buildListTile(
                color: AppDarkColor().iconSecondarycolor,
                icon: Icons.logout,
                text: 'Log out',
                onTap: () {
                  AppInfoDialog.showInfoDialog(
                      context: context,
                      callBack: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pop(context);

                          Navigator.pushNamed(
                              context, MyAppRouteConst.loginRoute);
                        }).catchError((error) {
                          print('Sign out failed: $error');
                        });
                      },
                      title: 'Are You Sure?',
                      buttonText: 'Log Out');

                  // Add your onTap code here
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static ListTile _buildListTile(
      {required IconData icon,
      required String text,
      required VoidCallback onTap,
      Color? color}) {
    return ListTile(
      splashColor: Colors.transparent,
      leading: Icon(icon, color: AppDarkColor().iconSoftColor),
      title: Text(
        text,
        style: TextStyle(color: color ?? AppDarkColor().iconSoftColor),
      ),
      onTap: onTap,
    );
  }
}
