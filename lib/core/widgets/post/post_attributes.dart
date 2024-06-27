import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';

class PostAttributes extends StatelessWidget {
  const PostAttributes(
      {super.key,
      required this.icon,
      required this.count,
      required this.onTap});
  final Icon icon;
  final int count;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          AppSizedBox.sizedBox5W,
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
