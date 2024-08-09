import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';

class AiChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final String? timestamp;

  const AiChatBubble({
    super.key,
    required this.text,
    required this.isSentByMe,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // if (timestamp != null)
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   child: Text(
        //     timestamp!,
        //     style: TextStyle(
        //       color: Colors.grey,
        //       fontSize: 12,
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          decoration: BoxDecoration(
            color: isSentByMe ? Colors.blue : Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppBorderRadius.getRadius(20)),
              topRight: Radius.circular(AppBorderRadius.getRadius(20)),
              bottomLeft: isSentByMe
                  ? Radius.circular(AppBorderRadius.getRadius(20))
                  : Radius.zero,
              bottomRight: isSentByMe
                  ? Radius.zero
                  : Radius.circular(AppBorderRadius.getRadius(20)),
            ),
          ),
          child: Text(text, style: Theme.of(context).textTheme.labelMedium),
        ),
      ],
    );
  }
}
