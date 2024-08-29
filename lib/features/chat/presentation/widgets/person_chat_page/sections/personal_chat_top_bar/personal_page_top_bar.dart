import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/app_msg/app_info_msg.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/core/widgets/dialog/popup_menu.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
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
                : BlocListener<MessageCubit, MessageState>(
                    listener: (context, state) {
                      if (state is DeleteMessageSuccess) {
                        selectedMessages.value = [];
                      }
                    },
                    child: PersonalChatTopBarIcon(
                      onPressed: () {
                        // Check if any message is older than 30 minutes
                        bool canDelete = true;
                        final now = DateTime.now();
                        for (var message in selectedMessages.value) {
                          final difference =
                              now.difference(message.createdAt!.toDate());
                          if (difference.inMinutes > 30) {
                            canDelete = false;
                            break;
                          }
                        }

                        if (canDelete) {
                          AppInfoDialog.showInfoDialog(
                            context: context,
                            subtitle: AppIngoMsg.deleteMessage,
                            callBack: () {
                              context.read<MessageCubit>().deleteMessage(
                                  messageState: getMessageCubit.state,
                                  messages: selectedMessages.value);
                            },
                            buttonText: AppUiStringConst.delete,
                          );
                        } else {
                          // Show a snackbar indicating the message cannot be deleted
                          Messenger.showSnackBar(
                              message: AppLocalizations.of(context)!
                                  .cannotDeleteMessage);
                        }
                      },
                      index: 0,
                    ),
                  );
          },
        ),
        ReusablePopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          items: [
            // if (getMessageCubit.state.statusInfo?.isBlockedByMe == null ||
            //     getMessageCubit.state.statusInfo?.isBlockedByMe == true)
            //   PopupMenuItem(
            //     onTap: () {
            //       context.read<MessageCubit>().blockOrUnblockThisChat(
            //           isBlock: true, messageState: getMessageCubit.state);
            //     },
            //     child: ChatActionWidget(
            //         asset: AppAssetsConst.block,
            //         text:
            //             getMessageCubit.state.statusInfo?.isBlockedByMe == true
            //                 ? 'Unblock'
            //                 : AppLocalizations.of(context)!.block),
            //   ),
            PopupMenuItem(
              onTap: () {
                AppInfoDialog.showInfoDialog(
                    context: context,
                    title: 'Clear Chat?',
                    buttonText: 'Clear',
                    subtitle:
                        'This will only clear chat history from your side',
                    callBack: () {
                      context
                          .read<MessageCubit>()
                          .clearChat(getMessageCubit.state);
                    });
              },
              child: ChatActionWidget(
                  asset: AppAssetsConst.clear,
                  text: AppLocalizations.of(context)!.clear_chat),
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChatActionWidget extends StatelessWidget {
  const ChatActionWidget(
      {super.key, this.size = 24, required this.asset, required this.text});
  final String asset;
  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSvgIcon(
          assetPath: asset,
          height: size,
        ),
        AppSizedBox.sizedBox10W,
        CustomText(text: text)
      ],
    );
  }
}
