import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/common_widgets/personal_chat_top_bar_icon.dart';

class PersonalPageTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalPageTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: !isThatTabOrDeskTop,
      title: BlocSelector<GetMessageCubit, GetMessageState, UserStatusInfo?>(
        selector: (state) => state.statusInfo,
        builder: (context, user) {
          log('rebiot');
          if (user != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.userName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: isThatTabOrDeskTop ? 15 : null)),
                Text(
                    user.isOnline
                        ? AppUiStringConst.online
                        : user.lastSeen?.toDate().onlineStatus() ?? '',
                    style: AppTextTheme.bodyMeidumwhiteVariant.bodyMedium
                        ?.copyWith(
                            fontSize: isThatTabOrDeskTop ? 11 : 11.sp,
                            color: AppDarkColor().chatTileGradientOne))
              ],
            );
          }
          return const EmptyDisplay();
        },
      ),
      actions: [
        PersonalChatTopBarIcon(onPressed: () {}, index: 0),
        PersonalChatTopBarIcon(onPressed: () {}, index: 1),
        PersonalChatTopBarIcon(onPressed: () {}, index: 2),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
