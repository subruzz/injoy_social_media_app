import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/presentation/pages/person_chat_page.dart';
import 'package:social_media_app/features/chat/presentation/pages/personal_chat_builder.dart';

import '../../../../../../core/theme/color/app_colors.dart';

class ChatCallItem extends StatelessWidget {
  final String name;
  final String time;
  final bool isCall;
  final String otherUserId;
  final ChatEntity? chat;
  const ChatCallItem(
      {super.key,
      required this.otherUserId,
      required this.name,
      required this.time,
      this.isCall = false,
      required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
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
        name,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      subtitle: Text(time, style: Theme.of(context).textTheme.bodyMedium),
      trailing: isCall
          ? const Icon(Icons.call, color: Colors.white)
          : Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppDarkColor().secondaryPrimaryText),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text('2'),
                  ),
                ),
                Text(
                  style: Theme.of(context).textTheme.bodySmall,
                  chat!.createdAt.toDate().toCustomFormat(),
                )
              ],
            ),
    );
  }
}
