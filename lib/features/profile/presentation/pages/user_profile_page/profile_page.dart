import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_button_with_icon.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/post/presentation/bloc/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/pages/edit_post.dart';
import 'package:social_media_app/core/widgets/post/each_post.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/delete_post_popup.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_tab.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_fullname.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_social_attribute.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_tab.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/vertical_divider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserBloc>().appUser;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              user.userName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  CustomBottomSheet.showOptions(context);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Profile info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    UserProfile(
                      profileImage: user.profilePic,
                    ),
                    AppSizedBox.sizedBox10H,
                    ProfileUserDetailText(
                      fullName: user.fullName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSizedBox.sizedBox5H,
                    if (user.occupation != null)
                      ProfileUserDetailText(
                        fullName: user.occupation ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    AppSizedBox.sizedBox5H,
                    if (user.about != null)
                      ProfileUserDetailText(
                        fullName: user.about ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppDarkColor().secondaryText),
                      ),
                    AppSizedBox.sizedBox15H,
                    CustomAppPadding(
                      padding: AppPadding.horizontalExtraLarge,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UserSocialAttribute(
                              attribute: user.posts, attributeName: 'Posts'),
                          const CustomVerticalDivider(),
                          UserSocialAttribute(
                              attribute: user.followers,
                              attributeName: 'Followers'),
                          const CustomVerticalDivider(),
                          UserSocialAttribute(
                              attribute: user.following,
                              attributeName: 'Following'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TabBar(
                      dividerColor: AppDarkColor().secondaryBackground,
                      indicatorColor: AppDarkColor().iconSecondarycolor,
                      tabs: const [
                        UserTab(
                            icon: Icons.add_photo_alternate_rounded,
                            tabTitle: 'Media'),
                        UserTab(
                            icon: Icons.add_to_photos_sharp, tabTitle: 'Posts')
                      ],
                    ),
                  ],
                ),
              ),
              // TabBarView for displaying content of each tab
              Expanded(
                child: TabBarView(
                  children: [
                    const MediaTab(),
                    PostsTab(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
        builder: (context, state) {
      if (state is GetUserPostsSuccess) {
        return ListView.builder(
          itemCount: state.userPosts.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            print(state.userPosts.length);
            final userPost = state.userPosts[index];
            return EachPost(
              currentPost: userPost,
              onShare: () {},
              onTurnOffCommenting: () {},
              onEdit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditPostPage(
                      post: userPost,
                      userAllPostImages: state.userAllPostImages,
                      index: index,
                      allUserStatuses: state.userPosts),
                ));
              },
              onDelete: () {
                showDialog(
                  context: context,
                  builder: (context) => DeleteConfirmationPopup(onConfirm: () {
                    context
                        .read<DeletePostBloc>()
                        .add(DeletePost(postId: userPost.postId));
                  }, onCancel: () {
                    Navigator.pop(context);
                  }),
                );
              },
              isEdit: true,
            );
          },
        );
      }
      return SizedBox();
    });
  }
}

Widget _buildIconWithCount(IconData icon, int count, [Color? iconColor]) {
  return Row(
    children: [
      Icon(
        icon,
        size: 18,
        color: iconColor ?? Colors.white,
      ),
      const SizedBox(width: 5),
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    ],
  );
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
                icon: Icons.edit,
                text: 'Edit Interests',
                onTap: () {
                  context.pop(context);
                  context.pushNamed(MyAppRouteConst.interestSelectRoute,
                      extra: context.read<AppUserBloc>().appUser.interests);
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
              //   icon: Icons.history,
              //   text: 'Your Activity',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Add your onTap code here
              //   },
              // ),
              _buildListTile(
                icon: Icons.qr_code,
                text: 'QR Code',
                onTap: () {
                  Navigator.pop(context);
                  // Add your onTap code here
                },
              ),
              _buildListTile(
                icon: Icons.bookmark,
                text: 'Saved',
                onTap: () {
                  Navigator.pop(context);
                  // Add your onTap code here
                },
              ),
              // _buildListTile(
              //   icon: Icons.people,
              //   text: 'Close Friends',
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Add your onTap code here
              //   },
              // ),
              _buildListTile(
                icon: Icons.favorite,
                text: 'Favorites',
                onTap: () {
                  Navigator.pop(context);
                  // Add your onTap code here
                },
              ),
              _buildListTile(
                color: AppDarkColor().iconSecondarycolor,
                icon: Icons.logout,
                text: 'Log out',
                onTap: () {
                  AppInfoDialog.showInfoDialog(
                      context: context,
                      callBack: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          context.pop(context);

                          context.goNamed(MyAppRouteConst.loginRoute);
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
      splashColor: Colors.transparent, // This removes the splash color

      leading: Icon(icon, color: AppDarkColor().iconSoftColor),
      title: Text(
        text,
        style: TextStyle(color: color ?? AppDarkColor().iconSoftColor),
      ),
      onTap: onTap,
    );
  }
}
