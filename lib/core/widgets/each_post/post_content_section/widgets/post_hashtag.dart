import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';

class PostHashtag extends StatefulWidget {
  const PostHashtag({
    super.key,
    required this.hashtags,
  });

  final List<String> hashtags;

  @override
  State<PostHashtag> createState() => _PostHashtagState();
}

class _PostHashtagState extends State<PostHashtag> {
  bool _showAllHashtags = false;

  @override
  Widget build(BuildContext context) {
    final hashtagsToDisplay = _showAllHashtags || widget.hashtags.length <= 4
        ? widget.hashtags
        : widget.hashtags.sublist(0, 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5,
          children: [
            ...hashtagsToDisplay.map((tag) => GestureDetector(
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
        if (widget.hashtags.length > 4)
          GestureDetector(
            onTap: () {
              setState(() {
                _showAllHashtags = !_showAllHashtags;
              });
            },
            child: Text(
              _showAllHashtags ? 'Show Less' : 'See More ➡️',
              style: AppTextTheme.getResponsiveTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.grey[500]),
            ),
          ),
      ],
    );
  }
}
