import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/extensions/localization.dart';
import 'package:social_media_app/features/reels/presentation/pages/reels_page.dart';

class ChatTopBarSection extends StatelessWidget implements PreferredSizeWidget {
  const ChatTopBarSection({super.key, required this.localizations});
  final AppLocalizations localizations;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: AppPadding.onlyLeftMedium,
        child: Text(
          localizations.chats,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReelsPage(),
            ));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
