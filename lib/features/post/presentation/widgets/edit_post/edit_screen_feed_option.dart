import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class EditScreenFeedOption extends StatelessWidget {
  const EditScreenFeedOption(
      {super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppDarkColor().softBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  size: 15,
                  icon,
                ),
              )),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
