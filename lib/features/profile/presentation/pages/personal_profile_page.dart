// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
// import 'package:social_media_app/core/const/extensions/localization.dart';
// import 'package:social_media_app/core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
// import 'package:social_media_app/core/theme/color/app_colors.dart';
// import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
// import 'package:social_media_app/features/premium_subscription/presentation/pages/premium_subscripti_builder.dart';
// import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/top_bar_section/top_bar_section.dart';
// import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';
// import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/user_profile_tab_section.dart';
// import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';
// import 'package:social_media_app/features/settings/presentation/pages/settings_page.dart';

// import '../../../../core/widgets/dialog/app_info_dialog.dart';
// import '../../../../core/routes/app_routes_const.dart';
// import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
// import '../../../../core/widgets/premium_badge.dart';

// class PersonalProfilePage extends StatefulWidget {
//   const PersonalProfilePage({super.key});

//   @override
//   State<PersonalProfilePage> createState() => _PersonalProfilePageState();
// }

// class _PersonalProfilePageState extends State<PersonalProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     log('personal page is built ');
//   }

//   @override
//   void dispose() {
//     log('personal page is disposed ');

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = context.read<AppUserBloc>().appUser;
//     final l10n = context.l10n;
//     return Scaffold(
//       appBar: ProfilePageTopBarSection(
//         localization: l10n,
//       ),
//       body: Center(
//         child: SizedBox(
//           child: DefaultTabController(
//             length: 2,
//             child: NestedScrollView(
//               headerSliverBuilder: (_, __) {
//                 return [
//                   SliverList(
//                       delegate: SliverChildListDelegate([
//                     Column(
//                       children: [
//                         const MyProfileBasicDetails(),
//                         AppSizedBox.sizedBox15H,
//                         UserSocialActionDetailsSection(
//                           localizations: l10n,
//                           user: user,
//                         ),
//                       ],
//                     ),
//                   ]))
//                 ];
//               },
//               body: UserProfileTabSection(
//                 localizations: l10n!,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomListTile extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final bool isPremium;
//   final VoidCallback onTap;
//   final Color? color;

//   const CustomListTile({
//     super.key,
//     required this.icon,
//     required this.text,
//     this.isPremium = false,
//     required this.onTap,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       splashColor: Colors.transparent,
//       leading: Icon(icon, color: AppDarkColor().iconSecondarycolor),
//       title: Row(
//         children: [
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(color: color ?? AppDarkColor().secondaryText),
//             ),
//           ),
//           if (isPremium) AppSizedBox.sizedBox10W,
//           if (isPremium) const PremiumBadge(),
//         ],
//       ),
//       onTap: onTap,
//     );
//   }
// }

// class CustomBottomSheet {
//   static void showOptions(BuildContext context, AppLocalizations localization) {
//     final appuser = context.read<AppUserBloc>().appUser;
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       backgroundColor: AppDarkColor().secondaryBackground,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CustomListTile(
//                 icon: Icons.settings,
//                 text: localization.settings,
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SettingsScreen(),
//                       ));
//                 },
//               ),
//               CustomListTile(
//                 isPremium: true,
//                 icon: Icons.people_alt_outlined,
//                 text: localization.seeWhoVisitedMe,
//                 onTap: () {
//                   appuser.hasPremium
//                       ? Navigator.pushNamed(
//                           context,
//                           MyAppRouteConst.userVisitedListingRoute,
//                         )
//                       : AppInfoDialog.showInfoDialog(
//                           title: 'Premium Feature',
//                           subtitle:
//                               'Unlock this feature with a premium subscription for an enhanced experience.',
//                           context: context,
//                           callBack: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const PremiumSubscriptiBuilder(),
//                                 ));
//                           },
//                           buttonText: 'Get Premium');
//                 },
//               ),
//               CustomListTile(
//                 isPremium: true,
//                 icon: Icons.language,
//                 text: localization.changeAppLanguage,
//                 onTap: () {
//                   if (appuser.hasPremium) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => LanguageSelectionDialog(
//                           languages: ['English', 'Malayalam', 'Hindi'],
//                           onLanguageSelected: (language) {
//                             context
//                                 .read<AppLanguageCubit>()
//                                 .changeLanguage(Locale('ml'));
//                           }),
//                     );
//                     return;
//                   }

//                   AppInfoDialog.showInfoDialog(
//                       title: 'Premium Feature',
//                       subtitle:
//                           'Unlock this feature with a premium subscription for an enhanced experience.',
//                       context: context,
//                       callBack: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const PremiumSubscriptiBuilder(),
//                             ));
//                       },
//                       buttonText: 'Get Premium');
//                 },
//               ),
//               if (!appuser.hasPremium)
//                 CustomListTile(
//                   icon: Icons.star,
//                   text: 'Get Premium',
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               const PremiumSubscriptiBuilder(),
//                         ));
//                   },
//                 ),
//               CustomListTile(
//                 color: AppDarkColor().iconSecondarycolor,
//                 icon: Icons.logout,
//                 text: localization.logOut,
//                 onTap: () {
//                   AppInfoDialog.showInfoDialog(
//                     context: context,
//                     callBack: () {
//                       FirebaseAuth.instance.signOut().then((value) {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginPage(),
//                           ),
//                           (route) => false,
//                         );
//                       }).catchError((error) {});
//                     },
//                     title: localization.areYouSure,
//                     buttonText: localization.logOut,
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
