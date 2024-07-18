import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/common_widgets/personal_chat_top_bar_icon.dart';

class PersonalPageTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PersonalPageTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Annete blcack',
              style: Theme.of(context).textTheme.headlineSmall),
          Text('Online', style: Theme.of(context).textTheme.bodySmall)
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
