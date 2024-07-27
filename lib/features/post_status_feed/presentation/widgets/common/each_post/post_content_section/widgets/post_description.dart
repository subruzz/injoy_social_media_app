import 'package:flutter/material.dart';

class PostDescription extends StatelessWidget {
  const PostDescription(
      {super.key, required this.description, this.seeFull = false});
  final String description;
  final bool seeFull;
  @override
  Widget build(BuildContext context) {
    return Text(description,
        overflow: seeFull ? null : TextOverflow.ellipsis,
        maxLines: seeFull ? null : 4,
        style: Theme.of(context).textTheme.bodyMedium);
  }
}
