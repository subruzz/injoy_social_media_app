import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_top_section/widgets/post_options_bottom_shett.dart';

class PostOptionButton extends StatelessWidget {
  const PostOptionButton(
      {super.key,
      this.isEdit = false,
      this.onShare,
      this.onSave,
      this.onHideUser,
      this.onAddToFavorite,
      this.onTurnOffCommenting,
      this.onEdit,
      this.onDelete,
      this.onAboutAccount});
  final bool isEdit;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onHideUser;
  final VoidCallback? onAddToFavorite;
  final VoidCallback? onTurnOffCommenting;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAboutAccount;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          PostOptionsBottomShett.showPostOptionBottomSheet(context,
              isEdit: isEdit,
              onShare: onShare,
              onSave: onSave,
              onHideUser: onHideUser,
              onAddToFavorite: onAddToFavorite,
              onTurnOffCommenting: onTurnOffCommenting,
              onEdit: onEdit,
              onDelete: onDelete,
              onAboutAccount: onAboutAccount);
        },
        icon: CustomSvgIcon(assetPath: AppAssetsConst.moreIcon));
  }
}
