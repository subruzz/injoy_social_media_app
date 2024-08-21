import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/features/settings/presentation/pages/account_settings_page.dart';

import '../../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../../../core/const/app_config/app_padding.dart';
import '../../../../../../core/const/assets/app_assets.dart';
import '../../../../../../core/theme/color/app_colors.dart';
import '../../../../../../core/utils/routes/tranistions/app_routes_const.dart';
import '../../../../../../core/widgets/app_related/app_padding.dart';
import '../../../../../../core/widgets/app_related/app_svg.dart';
import '../../../../../../core/widgets/dialog/general_dialog_for_web.dart';
import '../../../../../settings/presentation/pages/chat_settings_page.dart';
import '../../../../../settings/presentation/pages/notification_preference_screen.dart';
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
                  // if (isThatTabOrDeskTop) {
                  //   final RenderBox button =
                  //       context.findRenderObject() as RenderBox;
                  //   final RenderBox overlay = Overlay.of(context)
                  //       .context
                  //       .findRenderObject() as RenderBox;
                  //   final Offset position =
                  //       button.localToGlobal(Offset.zero, ancestor: overlay);
                  //   showMenu(
                  //       context: context,
                  //       position: RelativeRect.fromRect(
                  //         Rect.fromPoints(
                  //           position,
                  //           position.translate(
                  //               button.size.width, button.size.height),
                  //         ),
                  //         Offset.zero & overlay.size,
                  //       ),
                  //       items: [...getMySettingsMenuItemsForWeb(context)]);
                  //   return;
                  // }
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

//   List<PopupMenuEntry> getMySettingsMenuItemsForWeb(BuildContext context) {
//     return [
//       PopupMenuItem(
//         child: SettingsTile(
//             icon: Icons.account_circle,
//             title: 'Account',
//             onTap: () {
//               Navigator.pop(context);
//               GeneralDialogForWeb.showSideDialog(
//                   child: AccountSettingsPage(
//                     myId: context.read<AppUserBloc>().appUser.id,
//                   ),
//                   context: context);
//             }),
//       ),
//       PopupMenuItem(
//         child: SettingsTile(
//             icon: Icons.notifications,
//             title: 'Notifications',
//             onTap: () => GeneralDialogForWeb.showSideDialog(
//                 child: const NotificationPreferenceScreen(), context: context)),
//       ),
//       PopupMenuItem(
//         child: SettingsTile(
//             icon: Icons.chat,
//             title: 'Your library',
//             onTap: () => GeneralDialogForWeb.showSideDialog(
//                 child: const ChatSettingsPage(), context: context)),
//       ),
//       PopupMenuItem(
//         child: SettingsTile(
//           icon: Icons.lock,
//           title: 'Privacy',
//           onTap: () {
//             // Add your privacy-related navigation or logic here.
//           },
//         ),
//       ),
//       PopupMenuItem(
//         child: SettingsTile(
//           icon: Icons.security,
//           title: 'Security',
//         ),
//       ),
//       PopupMenuItem(
//         child: SettingsTile(
//           icon: Icons.help,
//           title: 'Help',
//         ),
//       ),
//       PopupMenuItem(
//         child: SettingsTile(
//           icon: Icons.info,
//           title: 'About',
//         ),
//       ),
//     ];
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// PopupMenuItem _buildMenuItem(
//     IconData icon, String title, BuildContext context) {
//   return PopupMenuItem(
//     value: title,
//     child: ListTile(
//       leading: Icon(icon, color: Colors.white),
//       title: Text(title, style: TextStyle(color: Colors.white)),
//     ),
//   );
// }

// class SettingsPopupMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.black,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Account',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold)),
//             Text('change username, delete account',
//                 style: TextStyle(color: Colors.grey)),
//             SizedBox(height: 20),
//             Text('Your Library',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//             ListTile(
//               leading: Icon(Icons.bookmark, color: Colors.white),
//               title: Text('Saved', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 // Navigate to saved
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.favorite, color: Colors.white),
//               title: Text('Liked', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 // Navigate to liked
//               },
//             ),
//             SizedBox(height: 20),
//             Text('Premium Features',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//             ListTile(
//               leading: Icon(Icons.person, color: Colors.white),
//               title: Text('See Who Visited Me',
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 // Navigate to see who visited me
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.language, color: Colors.white),
//               title: Text('Change app language',
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 // Change app language
//               },
//             ),
//             SizedBox(height: 20),
//             Text('Settings',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//             ListTile(
//               leading: Icon(Icons.notifications, color: Colors.white),
//               title:
//                   Text('Notifications', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 // Navigate to notifications
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.chat, color: Colors.white),
//               title: Text('Chat', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 // Navigate to chat
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}
