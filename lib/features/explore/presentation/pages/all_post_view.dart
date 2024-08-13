import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/each_post.dart';

import '../../../../core/common/entities/post.dart';

class AllPostView extends StatelessWidget {
  const AllPostView(
      {super.key, required this.initialIndex, required this.posts});
  final int initialIndex;
  final List<PostEntity> posts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          controller: ScrollController(
            initialScrollOffset: initialIndex == 0 ? 0 : initialIndex * 450.0,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return posts[index].isThatvdo
                ? const EmptyDisplay()
                : EachPost(currentPost: posts[index]);
          },
        ));
  }
}
