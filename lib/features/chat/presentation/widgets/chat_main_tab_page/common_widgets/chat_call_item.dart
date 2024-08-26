import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/presentation/pages/personal_chat_builder.dart';

import '../../../../../../core/theme/color/app_colors.dart';

class ChatCallItem extends StatelessWidget {
  final bool isCall;
  final String otherUserId;
  final ChatEntity? chat;
  final void Function(String id)? openChat;
  const ChatCallItem(
      {super.key,
      required this.otherUserId,
      this.isCall = false,
      required this.chat,
      this.openChat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (openChat != null) {
          openChat!(otherUserId);
          return;
        }
        if (chat != null) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PersonalChatBuilder(otherUserId: otherUserId),
          ));
          // context.read<MessageInfoStoreCubit>().setDataForChat(
          //     receiverProfile: chat!.recipientProfile,
          //     receiverName: chat!.recipientName ?? '',
          //     myName: me.userName ?? '',
          //     myProfil: me.profilePic,
          //     recipientId: chat!.recipientUid);
          // context.read<MessageCubit>().getPersonalChats(
          //     recipientId: otherUserId,
          //     sendorId: context.read<AppUserBloc>().appUser.id);
          // Navigator.pushNamed(
          //   context,
          //   MyAppRouteConst.personaChatRoute,
          // );
        }
      },
      leading: CircularUserProfile(
        profile: chat?.otherUserProfile,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              textAlign: TextAlign.start,
              text: chat?.otherUserName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: isThatTabOrDeskTop ? 16 : null),
              maxLines: 1,
            ),
          ),
          if (!isThatTabOrDeskTop && chat?.recentTextMessage.isEmpty == false)
            CustomText(
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: isThatTabOrDeskTop ? 13 : null),
              text: chat!.createdAt.toDate().toCustomFormat(),
            )
        ],
      ),
      subtitle: !isThatTabOrDeskTop
          ? Row(
              children: [
                Expanded(
                  child: CustomText(
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      text: chat!.recentTextMessage,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: isThatTabOrDeskTop ? 14 : null)),
                ),
                if (chat!.lastSenderId !=
                    context.read<AppUserBloc>().appUser.id)
                  DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppDarkColor().secondaryPrimaryText),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                    ),
                  ),
              ],
            )
          : null,
    );
  }
}
