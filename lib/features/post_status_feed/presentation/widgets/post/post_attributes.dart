import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';

class PostAttributes extends StatelessWidget {
  const PostAttributes({super.key, required this.icon, required this.count});
  final IconData icon;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
        ),
        AppSizedBox.sizedBox5W,
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
