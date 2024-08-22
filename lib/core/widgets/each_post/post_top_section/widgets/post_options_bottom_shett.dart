import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/services/assets/asset_services.dart';

import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/dialog/app_info_dialog.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/pages/edit_post.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';

class PostOptionsBottomShett {
  static showPostOptionBottomSheet(BuildContext context,
      {bool isMyPost = false,
      required PostEntity post,
      VoidCallback? onShare,
      VoidCallback? onSave,
      VoidCallback? onHideUser,
      VoidCallback? onAddToFavorite,
      VoidCallback? onTurnOffCommenting,
      VoidCallback? onEdit,
      VoidCallback? onDelete,
      VoidCallback? onAboutAccount,
      int currentPostIndex = 0,
      required int postImageUrlIndex}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final l10n = context.l10n;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CommonListTile(
              leading: AppAssetsConst.share,
              text: l10n!.share,
              onTap: () {},
              iconSize: 23,
            ),
            if (!isMyPost) ...[
              CommonListTile(
                leading: AppAssetsConst.download,
                text: l10n.downloadMedia,
                onTap: () {
                  Navigator.pop(context);

                  AssetServices.saveImageWithPath(
                      imageUrl: post.postImageUrl[postImageUrlIndex]);
                },
                iconSize: 23,
              ),

              // ListTile(
              //   leading: Icon(Icons.hide_source_outlined,
              //       color: AppDarkColor().iconPrimaryColor),
              //   title: const Text('Don\'t show post from this user'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     onHideUser?.call();
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.favorite,
              //       color: AppDarkColor().iconPrimaryColor),
              //   title: const Text('Add to favorite'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     onAddToFavorite?.call();
              //   },
              // ),
            ],
            if (isMyPost) ...[
              ListTile(
                leading: Icon(Icons.hide_source_rounded,
                    color: AppDarkColor().iconPrimaryColor),
                title: Text(l10n.turnOffCommenting),
                onTap: () {
                  Navigator.pop(context);
                  onTurnOffCommenting?.call();
                },
              ),
              ListTile(
                leading: Icon(Icons.edit_outlined,
                    color: AppDarkColor().iconPrimaryColor),
                title: Text(l10n.edit),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditPostPage(
                      post: post,
                      index: currentPostIndex,
                    ),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outlined,
                    color: AppDarkColor().iconSecondarycolor),
                title: Text(l10n.delete,
                    style: Theme.of(context).textTheme.labelLarge),
                onTap: () {
                  AppInfoDialog.showInfoDialog(
                      pop: false,
                      title: 'Are you Sure?',
                      context: context,
                      callBack: () {
                        context.read<CreatePostBloc>().add(PostDeleteEvent(
                            postId: post.postId,
                            postMedias: post.postImageUrl));
                      },
                      buttonChild:
                          BlocConsumer<CreatePostBloc, CreatePostState>(
                        builder: (context, state) {
                          log('post stat eis $state');

                          if (state is PostDeletionLoading) {
                            return const CircularLoading();
                          }
                          return Text(l10n.areYouSure);
                        },
                        listener: (context, state) {
                          if (state is PostDeletionSuccess) {
                            log('post stat esuccessis $state');

                            log('post deleted successfully');
                            context.read<GetUserPostsBloc>().add(
                                GetPostAfterDelete(index: currentPostIndex));
                            Messenger.showSnackBar(
                                message: l10n.post_deleted_success);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                      ));

                  onDelete?.call();
                },
              ),
            ],
            if (!isMyPost)
              CommonListTile(
                text: l10n.aboutThisAccount,
                leading: AppAssetsConst.user,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MyAppRouteConst.otherUserProfile,
                      arguments: {
                        'user': PartialUser(
                            id: post.creatorUid,
                            userName: post.userFullName,
                            fullName: post.userFullName,
                            profilePic: post.userProfileUrl)
                      });
                },
                iconSize: 22,
              ),
            if (!isMyPost)
              CommonListTile(
                text: l10n.report,
                iconSize: 22,
                extraColor: AppDarkColor().secondaryPrimaryText,
                leading: AppAssetsConst.report,
                onTap: () {},
              ),
          ],
        );
      },
    );
  }
}
