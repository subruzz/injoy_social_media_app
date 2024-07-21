import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/common_widgets/personal_chat_top_bar_icon.dart';

class PersonalPageTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalPageTopBar(
      {super.key, required this.userName, required this.id});
  final String userName;
  final String id;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userName, style: Theme.of(context).textTheme.headlineSmall),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(id)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('User not found');
                }

                final bool isOnline = snapshot.data!['onlineStatus'] ?? false;
                final Timestamp lastSeen = snapshot.data!['lastSeen'];
                return Text(
                  isOnline ? 'Online' : lastSeen.toDate().onlineStatus(),
                  style: AppTextTheme.bodyMeidumwhiteVariant.bodyMedium,
                );
              })
        ],
      ),
      actions: [
        PersonalChatTopBarIcon(onPressed: () {}, index: 0),
        PersonalChatTopBarIcon(onPressed: () {}, index: 1),
        PersonalChatTopBarIcon(onPressed: () {}, index: 2)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
