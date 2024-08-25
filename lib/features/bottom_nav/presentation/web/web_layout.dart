import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/utils/routes/tranistions/hero_dialog.dart';
import 'package:social_media_app/core/widgets/app_related/app_top_bar_text_with_premium.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/dialog/general_dialog_for_web.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import 'package:social_media_app/features/notification/presentation/pages/notification_page.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import '../../../../core/utils/di/init_dependecies.dart';
import '../../../chat/presentation/cubits/chat/chat_cubit.dart';
import '../../../explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import '../../../popup_new_post.dart';
import '../../../post_status_feed/presentation/bloc/for_you_posts/get_my_status/get_my_status_bloc.dart';
import '../../../reels/presentation/bloc/reels/reels_cubit.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({super.key});

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  int _currentIndex = 0;
  void changePage(int index, {bool showExtraPage = false}) {
    setState(() {
      if (showExtraPage) {
        showTheExtraSide = true;
      } else {
        showTheExtraSide = false;
      }
      _currentIndex = index;
    });
  }

  bool showTheExtraSide = false;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = getScreens(isWeb: true);
  }

  @override
  Widget build(BuildContext context) {
    if (showTheExtraSide) {
      Navigator.of(context, rootNavigator: true);
    }
    final user = context.read<AppUserBloc>().appUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return serviceLocator<FollowingPostFeedBloc>()
            ..add(FollowingPostFeedGetEvent(
                isLoadMore: false,
                lastDoc: null,
                isFirst: true,
                following: user.following,
                uId: user.id));
        }),
        BlocProvider(create: (context) {
          return serviceLocator<ReelsCubit>()..getReels(user.id);
        }),
        BlocProvider(
          create: (context) => serviceLocator<GetMyStatusBloc>()
            ..add(GetAllMystatusesEvent(uId: user.id)),
        ),
        BlocProvider(
            create: (context) => serviceLocator<GetAllStatusBloc>()
              ..add(GetAllstatusesEvent(uId: user.id))),
        BlocProvider(
          create: (context) => serviceLocator<ExploreAllPostsCubit>()
            ..getAllposts(myId: user.id),
        ),
        BlocProvider(
            create: (context) =>
                serviceLocator<ChatCubit>()..getMyChats(myId: user.id)),
      ],
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: _currentIndex == 3
                  ? MediaQuery.of(context).size.width * .06
                  : MediaQuery.of(context).size.width * .06,
              vertical: 30),
          child: Row(
            children: [
              Flexible(
                flex: isThatTab || showTheExtraSide ? 1 : 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            DrawerHeader(
                                child: showTheExtraSide || isThatTab
                                    ? Image.asset(AppAssetsConst.applogo)
                                    : const AppTopBarTextWithPremium()),
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  changePage(0);
                                },
                                text: 'Home',
                                asset: AppAssetsConst.home),
                            AppSizedBox.sizedBox30H,
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  changePage(1);
                                },
                                text: 'Explore',
                                asset: AppAssetsConst.search),
                            AppSizedBox.sizedBox30H,
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  changePage(2);
                                },
                                text: 'Shorts',
                                asset: AppAssetsConst.shorts),
                            AppSizedBox.sizedBox30H,
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  showTheExtraSide = true;
                                  changePage(3);
                                },
                                text: 'Chats',
                                asset: AppAssetsConst.chat),
                            AppSizedBox.sizedBox30H,
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  // setState(() {
                                  //   showTheExtraSide = true;
                                  // });
                                  showTheExtraSide = true;

                                  GeneralDialogForWeb.showSideDialog(
                                      context: context,
                                      child: NotificationPage(
                                        notificationCubit:
                                            serviceLocator<NotificationCubit>(),
                                      ));
                                },
                                text: 'Notification',
                                asset: AppAssetsConst.noti2),
                            AppSizedBox.sizedBox30H,
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  Navigator.of(context).push(HeroDialogRoute(
                                      builder: (context) => PopupNewPostWeb()));
                                },
                                text: 'Create',
                                asset: AppAssetsConst.add),
                            AppSizedBox.sizedBox30H,
                            WebLayoutDrawwer(
                                showText: !showTheExtraSide,
                                changePage: () {
                                  changePage(4);
                                },
                                text: 'Profile',
                                asset: AppAssetsConst.person)
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 4,
                    )
                  ],
                ),
              ),
              // if (showTheExtraSide)
              //   Flexible(
              //     flex: 3,
              //     child: Container(
              //       color: Colors.green,
              //       child: NotificationPage(),
              //     ),
              //   ),

              Flexible(
                flex: 7,
                child: WebWidthHelper(
                    width: _currentIndex == 3 || _currentIndex == 2
                        ? double.infinity
                        : _currentIndex == 1
                            ? 700
                            : 600,
                    isCentre: !Responsive.isDesktop(context),
                    child: _pages[_currentIndex]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SplitColorWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 700,
//       height: 1500,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           // Left side (1/3 of the width) with red color
//           Container(
//             width: 400,
//             height: 700,
//             color: Colors.red,
//           ),
//           // Right side (2/3 of the width) with pink color
//           Container(
//             width: 600,
//             height: 700,
//             color: Colors.pink,
//           ),
//         ],
//       ),
//     );
//   }
// }

class WebLayoutDrawwer extends StatelessWidget {
  const WebLayoutDrawwer(
      {super.key,
      required this.changePage,
      required this.text,
      required this.showText,
      required this.asset});
  final VoidCallback changePage;
  final String text;
  final String asset;
  final bool showText;
  @override
  Widget build(BuildContext context) {
    return CommonListTile(
      showTrail: false,
      iconSize: 27,
      onTap: changePage,
      text: Responsive.isDesktop(context) && showText ? text : null,
      leading: asset,
    );
  }
}
