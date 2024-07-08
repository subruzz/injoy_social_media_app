import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/button/custom_button_with_icon.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/post/presentation/bloc/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/pages/edit_post.dart';
import 'package:social_media_app/core/widgets/post/each_post.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/delete_post_popup.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_fullname.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_social_attribute.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_tab.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/vertical_divider.dart';
import 'package:social_media_app/init_dependecies.dart';

class OtherUserProfilePage extends StatelessWidget {
  const OtherUserProfilePage(
      {super.key, required this.userName, required this.otherUserId});
  final String userName;
  final String otherUserId;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<OtherProfileCubit>()..getOtherProfile(otherUserId),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetOtherUserPostsCubit>()
            ..getOtherUserPosts(otherUserId),
        ),
      ],
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                userName,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
            body: BlocConsumer<OtherProfileCubit, OtherProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is OtherProfileError) {
                  return Text('no user');
                }
                if (state is OtherProfileLoading) {
                  return const CircularLoading();
                }
                if (state is OtherProfileSuccess) {
                  final currentUser = state.userProfile;
                  return Column(
                    children: [
                      // Profile info
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            UserProfile(
                              profileImage: state.userProfile.profilePic,
                            ),
                            AppSizedBox.sizedBox10H,
                            ProfileUserDetailText(
                              fullName: state.userProfile.fullName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            // AppSizedBox.sizedBox5H,
                            // ProfileUserDetailText(
                            //   fullName: user.occupation ?? '',
                            //   style: Theme.of(context).textTheme.bodySmall,
                            // ),
                            // AppSizedBox.sizedBox5H,
                            // ProfileUserDetailText(
                            //   fullName: user.about ?? '',
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodySmall
                            //       ?.copyWith(color: AppDarkColor().secondaryText),
                            // ),
                            AppSizedBox.sizedBox15H,
                            CustomAppPadding(
                              padding: AppPadding.horizontalExtraLarge,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  UserSocialAttribute(
                                      attribute: state.userProfile.posts,
                                      attributeName: 'Posts'),
                                  const CustomVerticalDivider(),
                                  BlocBuilder<FollowunfollowCubit,
                                      FollowunfollowState>(
                                    builder: (context, state) {
                                      int followers = currentUser.followers.length;
                                      return UserSocialAttribute(
                                          attribute: currentUser.followers,
                                          attributeName: 'Followers');
                                    },
                                  ),
                                  const CustomVerticalDivider(),
                                  UserSocialAttribute(
                                      attribute: state.userProfile.following,
                                      attributeName: 'Following'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomAppPadding(
                              padding: AppPadding.horizontalSmall,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: BlocConsumer<FollowunfollowCubit,
                                          FollowunfollowState>(
                                    builder: (context, state) {
                                      return CustomButtonWithIcon(
                                          iconSize: 20.w,
                                          iconData: Icons.person_add_alt,
                                          radius: AppBorderRadius
                                              .horizontalExtraLarge,
                                          title: user.following
                                                  .contains(currentUser.id)
                                              ? 'Following'
                                              : 'Follow',
                                          onClick: () {
                                            final amIFollowing = user.following
                                                .contains(currentUser.id);
                                            if (amIFollowing) {
                                              context
                                                  .read<FollowunfollowCubit>()
                                                  .unfollowUser(
                                                      myId: user.id,
                                                      otherId: currentUser.id);
                                            } else {
                                              context
                                                  .read<FollowunfollowCubit>()
                                                  .followUser(
                                                      myId: user.id,
                                                      otherId: currentUser.id);
                                            }
                                          });
                                    },
                                    listener: (context, state) {
                                      if (state is FollowUnfollowFailure) {
                                        Messenger.showSnackBar(
                                            message: state.errorMsg);
                                      }
                                      if (state is FollowSucess) {
                                        user.following.add(currentUser.id);
                                      }
                                      if (state is UnfollowSucess) {
                                        user.following.remove(currentUser.id);
                                      }
                                    },
                                  )),
                                  AppSizedBox.sizedBox10W,
                                  Expanded(
                                      child: CustomButtonWithIcon(
                                          iconColor:
                                              AppDarkColor().buttonBackground,
                                          iconSize: 20.w,
                                          iconData:
                                              CupertinoIcons.chat_bubble_text,
                                          borderColor:
                                              AppDarkColor().buttonBackground,
                                          color: AppDarkColor().background,
                                          radius: AppBorderRadius.extraLarge,
                                          title: 'Message',
                                          textColor: AppDarkColor()
                                              .secondaryPrimaryText,
                                          onClick: () {}))
                                ],
                              ),
                            ),
                            AppSizedBox.sizedBox10H,

                            TabBar(
                              dividerColor: AppDarkColor().secondaryBackground,
                              indicatorColor: AppDarkColor().iconSecondarycolor,
                              tabs: const [
                                UserTab(
                                    icon: Icons.add_photo_alternate_rounded,
                                    tabTitle: 'Media'),
                                UserTab(
                                    icon: Icons.add_to_photos_sharp,
                                    tabTitle: 'Posts')
                              ],
                            ),
                          ],
                        ),
                      ),
                      // TabBarView for displaying content of each tab
                      Expanded(
                        child: TabBarView(
                          children: [
                            BlocBuilder<GetOtherUserPostsCubit,
                                GetOtherUserPostsState>(
                              builder: (context, state) {
                                if (state is GetOtherUserPostsSuccess) {
                                  return MediaGrid(
                                      medias: state.userAllPostImages);
                                }
                                return GridView.builder(
                                    itemCount: 5,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) =>
                                        Shimmer.fromColors(
                                          baseColor: AppDarkColor()
                                              .secondaryBackground,
                                          highlightColor:
                                              AppDarkColor().softBackground,
                                          child: Container(
                                            color: Colors.grey,
                                            margin: const EdgeInsets.all(8.0),
                                          ),
                                        ));
                              },
                            ),
                            PostsTab(),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return EmptyDisplay();
              },
            ),
          )),
    );
  }
}

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOtherUserPostsCubit, GetOtherUserPostsState>(
        builder: (context, state) {
      if (state is GetOtherUserPostsSuccess) {
        return ListView.builder(
          itemCount: state.userPosts.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            print(state.userPosts.length);
            final userPost = state.userPosts[index];
            return EachPost(
              currentPost: userPost,
              onShare: () {
                // Implement share functionality
              },
              onTurnOffCommenting: () {
                // Implement turn off commenting functionality
              },
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
