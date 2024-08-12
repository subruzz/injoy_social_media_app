// import 'package:flutter/material.dart';
// import 'package:social_media_app/core/common/entities/post.dart';
// import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
// import 'package:social_media_app/core/const/extensions/time_stamp_to_string.dart';
// import 'package:social_media_app/core/widgets/expandable_text.dart';
// import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/post_action_section.dart';
// import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_content_section/widgets/post_hashtag.dart';
// import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_image_section.dart/widgets/post_multiple_images.dart';
// import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_image_section.dart/widgets/post_single_image.dart';

// class PostDetailsSection extends StatelessWidget {
//   const PostDetailsSection({super.key, required this.post});
//   final PostEntity post;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (post.description != null)
//           ExpandableText(
//             text: post.description ?? '',
//             trimLines: 2,
//           ),
//         AppSizedBox.sizedBox5H,
//         if (post.hashtags.isNotEmpty) PostHashtag(hashtags: post.hashtags),
//         AppSizedBox.sizedBox5H,
//         if (post.postImageUrl.isNotEmpty)
//           if (post.postImageUrl.isNotEmpty)
//             post.postImageUrl.length == 1
//                 ? PostSingleImage(
//                     imgUrl: post.postImageUrl[0],
//                     size: .5,
//                   )
//                 : PostMultipleImages(
//                     postImageUrls: post.postImageUrl,
//                     size: .5,
//                   ),
//         AppSizedBox.sizedBox3H,
//         Text(post.createAt.toDate().toCustomFormat()),
//         const Divider(),
//         SocialActions(
//           post: post,
//           likeAnim: () {},
//           isCommentOff: post.isCommentOff,
//         ),
//         const Divider(),
//         AppSizedBox.sizedBox10H,
//       ],
//     );
//   }
// }
