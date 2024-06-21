// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostTime extends StatelessWidget {
  const PostTime({
    super.key,
    required this.postTime,
  });
  final DateTime postTime;
  @override
  Widget build(BuildContext context) {
    return Text(
      timeago.format(postTime, locale: 'en'),
      style: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: AppDarkColor().secondaryText),
      overflow: TextOverflow.ellipsis, // Handle overflow by ellipsis
    );
  }
}
