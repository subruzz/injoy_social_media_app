import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PostFeedsOptions extends StatelessWidget {
  const PostFeedsOptions({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: AppDarkColor().iconPrimaryColor,),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
      onTap: () {
        // Handle tag people
      },
    );
  }
}
