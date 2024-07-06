import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/post/post_attributes.dart';
import 'package:social_media_app/features/post/presentation/bloc/like_post/like_post_bloc.dart';

class PostActionBar extends StatelessWidget {
  const PostActionBar({super.key, required this.post});
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AppUserBloc>().appUser!.id;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<LikePostBloc, LikePostState>(
          builder: (context, state) {
            return PostAttributes(
                onTap: () {
                  if (post.likes.contains(currentUserId)) {
                    post.likes
                        .removeWhere((element) => element == currentUserId);
                  } else {
                    post.likes.add(currentUserId);
                  }
                  context
                      .read<LikePostBloc>()
                      .add(LikePostClickEvent(postId: post.postId));
                },
                icon: !post.likes.contains(currentUserId)
                    ? const Icon(Icons.favorite_border)
                    : Icon(
                        Icons.favorite,
                        color: AppDarkColor().iconSecondarycolor,
                      ),
                count: post.likes.length);
          },
        ),
        AppSizedBox.sizedBox10W,
        PostAttributes(
          icon: Icon(
            Icons.chat_bubble_outline,
          ),
          count: 2,
          onTap: () {},
        ),
        Transform.rotate(
          angle: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send_outlined,
              size: 17,
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
