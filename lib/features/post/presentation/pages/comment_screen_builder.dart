// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/common/entities/post.dart';
// import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
// import 'package:social_media_app/features/post/presentation/pages/comment_screen.dart';

// import '../../../../init_dependecies.dart';
// import '../bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';

// class CommentScreenBuilder extends StatefulWidget {
//   const CommentScreenBuilder(
//       {super.key, required this.post, required this.onCommentAction});
//   final PostEntity post;
//   final void Function(num) onCommentAction;

//   @override
//   State<CommentScreenBuilder> createState() => _CommentScreenBuilderState();
// }

// class _CommentScreenBuilderState extends State<CommentScreenBuilder> {
//   final _commentBasic = serviceLocator<CommentBasicCubit>();
//   final _readComment = serviceLocator<GetPostCommentCubit>();
//   @override
//   void initState() {
//     _readComment.getPostComments(
//         postId: widget.post.postId, oncommentAction: widget.onCommentAction);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => serviceLocator<CommentBasicCubit>(),
//           ),
//           BlocProvider(
//             create: (context) => serviceLocator<GetPostCommentCubit>()
//               ..getPostComments(
//                   postId: widget.post.postId,
//                   oncommentAction: widget.onCommentAction),
//           ),
//         ],
//         child: CommentScreen(
//           post: widget.post,
//           commentBasicCubit: _commentBasic,
//           getPostCommentCubit: _readComment,
//         ));
//   }
// }
