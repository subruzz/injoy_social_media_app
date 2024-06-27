import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PostOptionsBottomShett {
  static showPostOptionBottomSheet(
    BuildContext context, {
    bool isEdit = false,
    VoidCallback? onShare,
    VoidCallback? onSave,
    VoidCallback? onHideUser,
    VoidCallback? onAddToFavorite,
    VoidCallback? onTurnOffCommenting,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    VoidCallback? onAboutAccount,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.send, color: AppDarkColor().iconPrimaryColor),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                onShare?.call();
              },
            ),
            if (!isEdit) ...[
              ListTile(
                leading: Icon(Icons.bookmark_add_sharp,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('Save'),
                onTap: () {
                  Navigator.pop(context);
                  onSave?.call();
                },
              ),
              ListTile(
                leading: Icon(Icons.hide_source_outlined,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('Don\'t show post from this user'),
                onTap: () {
                  Navigator.pop(context);
                  onHideUser?.call();
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('Add to favorite'),
                onTap: () {
                  Navigator.pop(context);
                  onAddToFavorite?.call();
                },
              ),
            ],
            if (isEdit) ...[
              ListTile(
                leading: Icon(Icons.hide_source_rounded,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('Turn off commenting'),
                onTap: () {
                  Navigator.pop(context);
                  onTurnOffCommenting?.call();
                },
              ),
              ListTile(
                leading: Icon(Icons.edit_outlined,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  onEdit?.call();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outlined,
                    color: AppDarkColor().iconSecondarycolor),
                title: Text('Delete',
                    style: Theme.of(context).textTheme.labelLarge),
                onTap: () {
                  Navigator.pop(context);
                  onDelete?.call();
                },
              ),
            ],
            if (!isEdit)
              ListTile(
                leading: Icon(Icons.person_pin,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('About this account'),
                onTap: () {
                  Navigator.pop(context);
                  onAboutAccount?.call();
                },
              ),
          ],
        );
      },
    );
  }
}
