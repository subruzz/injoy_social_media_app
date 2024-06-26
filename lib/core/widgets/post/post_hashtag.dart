// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PostHashtag extends StatelessWidget {
  const PostHashtag({
    super.key,
    required this.hashtags,
  });
  final List<String> hashtags;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: hashtags
          .map((tag) => Text(
                '#$tag',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blue,
                    ),
              ))
          .toList(),
    );
  }
}
