import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class ChatSideBar extends StatelessWidget {
  const ChatSideBar({super.key, this.isMe = false});
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isMe ? AppDarkColor().chatSideBar : AppDarkColor().chatCommon,
        borderRadius: BorderRadius.only(
            topLeft: ChatConstants.commonborderRadius12,
            bottomLeft: ChatConstants.commonborderRadius12),
      ),
      width: 5.w,
    );
  }
}