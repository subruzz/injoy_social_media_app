import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/features/reels/presentation/pages/reels_page.dart';

class ChatTopBarSection extends StatelessWidget implements PreferredSizeWidget {
  const ChatTopBarSection({super.key, required this.localizations});
  final AppLocalizations localizations;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: !isThatTabOrDeskTop,
      title: Padding(
        padding: AppPadding.onlyLeftMedium,
        child: Text(
          localizations.chats,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: isThatTabOrDeskTop ? 18 : null),
        ),
      ),
      actions: const <Widget>[
        // IconButton(
        //   icon: const Icon(Icons.search),
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => ReelsPage(),
        //     ));
        //   },
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
