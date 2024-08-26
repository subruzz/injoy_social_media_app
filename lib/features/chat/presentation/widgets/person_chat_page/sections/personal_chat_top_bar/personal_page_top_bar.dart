import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/app_msg/app_info_msg.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/common_widgets/personal_chat_top_bar_icon.dart';

import '../../../../../../../core/widgets/dialog/app_info_dialog.dart';
import '../../../../../domain/entities/message_entity.dart';

class PersonalPageTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalPageTopBar({
    super.key,
    required this.getMessageCubit,
    required this.selectedMessages,
  });
  final GetMessageCubit getMessageCubit;
  final ValueNotifier<List<MessageEntity>> selectedMessages;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: !isThatTabOrDeskTop,
      title: BlocSelector<GetMessageCubit, GetMessageState, UserStatusInfo?>(
        bloc: getMessageCubit,
        selector: (state) => state.statusInfo,
        builder: (context, user) {
          log('rebiot');
          if (user != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularUserProfile(size: 20, profile: user.userPic),
                AppSizedBox.sizedBox5W,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: user.userName,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: isThatTabOrDeskTop ? 15 : null)),
                      if (context.read<AppUserBloc>().appUser.showLastSeen &&
                          user.showOnline)
                        CustomText(
                            textAlign: TextAlign.start,
                            text: user.isOnline
                                ? AppUiStringConst.online
                                : user.lastSeen?.toDate().onlineStatus() ?? '',
                            style: AppTextTheme.getResponsiveTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: isThatTabOrDeskTop ? 11 : 11.sp,
                                    color: AppDarkColor().chatTileGradientOne))
                    ],
                  ),
                ),
              ],
            );
          }
          return const EmptyDisplay();
        },
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: selectedMessages,
          builder: (context, value, child) {
            return value.isEmpty
                ? const EmptyDisplay()
                : PersonalChatTopBarIcon(
                    onPressed: () {
                      AppInfoDialog.showInfoDialog(
                        context: context,
                        subtitle: AppIngoMsg.deleteMessage,
                        callBack: () {
                          log('deleting message');
                          context.read<MessageCubit>().deleteMessage(
                              messageState: getMessageCubit.state,
                              messages: selectedMessages.value);
                        },
                        buttonText: AppUiStringConst.delete,
                      );
                    },
                    index: 0);
          },
        ),
        PersonalChatTopBarIcon(onPressed: () {}, index: 1),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
