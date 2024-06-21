import 'package:flutter/material.dart';

class PostDescription extends StatelessWidget {
  const PostDescription({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Text(description,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        style: Theme.of(context).textTheme.bodyMedium);
  }
}
