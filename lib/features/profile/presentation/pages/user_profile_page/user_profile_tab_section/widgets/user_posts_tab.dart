import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/post/each_post.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/pages/edit_post.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/delete_post_popup.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
        builder: (context, state) {
      if (state is GetUserPostsSuccess) {
        return ListView.builder(
          itemCount: state.userPosts.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final userPost = state.userPosts[index];
            return EachPost(
              currentPost: userPost,
              onShare: () {},
              onTurnOffCommenting: () {},
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
