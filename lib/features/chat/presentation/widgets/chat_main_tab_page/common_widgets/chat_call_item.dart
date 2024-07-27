import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';

import '../../../../../../core/theme/color/app_colors.dart';

class ChatCallItem extends StatelessWidget {
  final String name;
  final String time;
  final bool isCall;
  final ChatEntity? chat;
  const ChatCallItem(
      {super.key,
      required this.name,
      required this.time,
      this.isCall = false,
      required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (chat != null) {
          context.read<MessageInfoStoreCubit>().setDataForChat(
       
              receiverProfile: chat!.recipientProfile,
              receiverName: chat!.recipientName,
              recipientId: chat!.recipientUid);
          Navigator.pushNamed(
            context,
            MyAppRouteConst.personaChatRoute,
          );
        }
      },
      leading: CircularUserProfile(
        profile: chat?.recipientProfile,
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
                  chat!.createdAt.toDate().timeAgoChatExtension(),
                )
              ],
            ),
    );
  }
}
