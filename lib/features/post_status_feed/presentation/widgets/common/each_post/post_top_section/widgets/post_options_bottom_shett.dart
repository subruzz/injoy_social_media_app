import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class PostOptionsBottomShett {
  // static Future<void> downloadImage(String imageUrl) async {
  //   // Request storage permission
  //   PermissionStatus permissionStatus =
  //       await Permission.storage.request();
  //   if (!permissionStatus.isGranted) {
  //     print('Storage permission not granted');
  //     return;
  //   }

  //   try {
  //     // Get the directory to save the image (Public Pictures Directory)
  //     Directory? directory = await getExternalStorageDirectory();
  //     if (directory == null) {
  //       print('Unable to get external storage directory');
  //       return;
  //     }

  //     // Create a public directory if it doesn't exist
  //     final publicPicturesDir = Directory('/storage/emulated/0/Pictures');
  //     if (!await publicPicturesDir.exists()) {
  //       await publicPicturesDir.create(recursive: true);
  //     }

  //     String filePath =
  //         '${publicPicturesDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

  //     // Download the image
  //     final response = await http.get(Uri.parse(
  //         'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg'));
  //     if (response.statusCode == 200) {
  //       File file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes);

  //       print('Image saved to $filePath');
  //     } else {
  //       print('Failed to download image');
  //     }
  //   } catch (e) {
  //     print('Error downloading image: $e');
  //   }
  // }

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
                leading: Icon(Icons.download_for_offline_outlined,
                    color: AppDarkColor().iconPrimaryColor),
                title: const Text('download Image'),
                onTap: () {
                  Navigator.pop(context);

                 
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
              BlocListener<DeletePostBloc, DeletePostState>(
                listener: (context, state) {
                  if (state is DeletePostSuccess) {
                    // context.read<GetUserPostsBloc>().add(
                    //     GetUserPostsrequestedEvent(
                    //         uid: context.read<AppUserBloc>().appUser.id));
                    Navigator.pop(context);
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.delete_outlined,
                      color: AppDarkColor().iconSecondarycolor),
                  title: Text('Delete',
                      style: Theme.of(context).textTheme.labelLarge),
                  onTap: () {
                    Navigator.pop(context);
                    onDelete?.call();
                  },
                ),
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
