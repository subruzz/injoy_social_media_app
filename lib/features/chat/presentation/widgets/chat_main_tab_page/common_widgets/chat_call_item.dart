import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/presentation/pages/personal_chat_builder.dart';

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
        print('clicked');
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
      title: Text(
        chat?.otherUserName ?? '',
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(fontSize: isThatTabOrDeskTop ? 16 : null),
      ),
      subtitle: !isThatTabOrDeskTop
          ? CustomText(
              textAlign: TextAlign.start,
              text: chat!.recentTextMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: isThatTabOrDeskTop ? 14 : null))
          : null,
      trailing: Column(
        children: [
          // DecoratedBox(
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: AppDarkColor().secondaryPrimaryText),
          //   child: const Padding(
          //     padding: EdgeInsets.all(6.0),
          //     child: Text('2'),
          //   ),
          // ),
          if (!isThatTabOrDeskTop)
            CustomText(
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: isThatTabOrDeskTop ? 13 : null),
              text: chat!.createdAt.toDate().toCustomFormat(),
            )
        ],
      ),
    );
  }
}
