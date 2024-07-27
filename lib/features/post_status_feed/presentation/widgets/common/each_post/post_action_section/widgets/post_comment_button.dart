import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/pages/comment_screen.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/social_action_text.dart';

import '../../../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../../post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';

class PostCommentButton extends StatelessWidget {
  const PostCommentButton({super.key, required this.post});
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              context
                  .read<GetPostCommentCubit>()
                  .getPostComments(postId: post.postId);
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => CommentScreen(
                        post: post,
                      ));
            },
            child: const CustomSvgIcon(
              assetPath: AppAssetsConst.commentIcon,
              height: 20,
              width: 20,
            )),
        AppSizedBox.sizedBox5W,
        BlocBuilder<CommentBasicCubit, CommentBasicState>(
          buildWhen: (previous, current) =>
              current is CommentDeletedSuccess ||
              current is CommentAddedSuccess,
          builder: (context, state) {
            return Builder(builder: (context) {
              return SocialActionText(
                text: post.totalComments.toString(),
              );
            });
          },
        ),
      ],
    );
  }
}
