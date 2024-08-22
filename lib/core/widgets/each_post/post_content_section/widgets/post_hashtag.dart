import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';

class PostHashtag extends StatelessWidget {
  const PostHashtag({
    super.key,
    required this.hashtags,
  });

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5,
          children: [
            ...hashtags.map((tag) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MyAppRouteConst.hashtagPostsRoute,
                      arguments: {'hashTagName': tag},
                    );
                  },
                  child: Text(
                    '#$tag',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.blue,
                          fontSize: isThatTabOrDeskTop ? 15 : null,
                        ),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
