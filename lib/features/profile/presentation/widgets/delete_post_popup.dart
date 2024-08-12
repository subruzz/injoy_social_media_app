import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class DeleteConfirmationPopup extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteConfirmationPopup({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppDarkColor().background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Delete this post?',
        style: TextStyle(color: AppDarkColor().primaryText),
      ),
      content: Text(
        'Do you really want to delete this post? This action cannot be undone.',
        style: TextStyle(color: AppDarkColor().primaryText),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: TextStyle(color: AppDarkColor().iconPrimaryColor),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: BlocConsumer<DeletePostBloc, DeletePostState>(
            listener: (context, state) {
              if (state is DeletePostSuccess) {
                Navigator.pop(context);
                // context.read<GetUserPostsBloc>().add(GetUserPostsrequestedEvent(
                //     uid: context.read<AppUserBloc>().appUser!.id));
                Messenger.showSnackBar(message: 'Post Deleted');
              }
              if (state is DeletePostFailure) {
                Navigator.pop(context);
                Messenger.showSnackBar(
                    message:
                        'An unexpected error occured during deleting,Please try again!');
              }
            },
            builder: (context, state) {
              if (state is DeletePostLoading) {
                return const CircularLoading();
              }
              return Text('Delete');
            },
          ),
        )
      ],
    );
  }
}
