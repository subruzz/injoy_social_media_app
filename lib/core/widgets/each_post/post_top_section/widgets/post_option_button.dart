import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/common/app_svg.dart';
import 'package:social_media_app/core/widgets/each_post/post_top_section/widgets/post_options_bottom_shett.dart';

class PostOptionButton extends StatelessWidget {
  const PostOptionButton(
      {super.key,
      this.isMyPost = false,
      this.onShare,
      this.onSave,
      this.onHideUser,
      this.onAddToFavorite,
      this.onTurnOffCommenting,
      this.onEdit,
      this.onDelete,
      this.onAboutAccount,
      this.isShorts = false,
      required this.post,
      required this.currentPostIndex,
      required this.pagecontroller});
  final bool isMyPost;
  final PostEntity post;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onHideUser;
  final VoidCallback? onAddToFavorite;
  final VoidCallback? onTurnOffCommenting;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAboutAccount;
  final PageController pagecontroller;
  final int currentPostIndex;
  final bool isShorts;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          PostOptionsBottomShett.showPostOptionBottomSheet(context,
              isShorts: isShorts,
              post: post,
              isMyPost: isMyPost,
              onShare: onShare,
              currentPostIndex: currentPostIndex,
              postImageUrlIndex: pagecontroller.hasClients
                  ? pagecontroller.page?.round() ?? 0
                  : 0,
              onSave: onSave,
              onHideUser: onHideUser,
              onAddToFavorite: onAddToFavorite,
              onTurnOffCommenting: onTurnOffCommenting,
              onEdit: onEdit,
              onDelete: onDelete,
              onAboutAccount: onAboutAccount);
        },
        icon: isShorts
            ? const Icon(Icons.more_horiz)
            : const CustomSvgIcon(assetPath: AppAssetsConst.moreIcon));
  }
}
