import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/post/post_option_button.dart';
import 'package:social_media_app/core/widgets/post/post_owner_image.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/pages/edit_post.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class PostUserDetailsSection extends StatelessWidget {
  const PostUserDetailsSection(
      {super.key, required this.post, required this.isEdit});
  final PostEntity post;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PostOwnerImage(ownerImage: post.userProfileUrl),
        AppSizedBox.sizedBox10W,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.userFullName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text('@${post.username}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const Spacer(),
        if (isEdit)
          PostOptionButton(
            isEdit: true,
            onDelete: () {
              context
                  .read<DeletePostBloc>()
                  .add(DeletePost(postId: post.postId));
                  
            },
            onEdit: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostPage(
                        post: post,
                        userAllPostImages: [],
                        index: 0,
                        allUserStatuses: []),
                  ));
            },
          )

        // const PostOptionButton(isEdit: false),
      ],
    );
  }
}
