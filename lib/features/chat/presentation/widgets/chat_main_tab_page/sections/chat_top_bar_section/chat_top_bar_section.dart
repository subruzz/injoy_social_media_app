import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';

class ChatTopBarSection extends StatelessWidget implements PreferredSizeWidget {
  const ChatTopBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: AppPadding.onlyLeftMedium,
        child: Text(
          'Chats',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
