import 'package:flutter/material.dart';
import 'package:social_media_app/core/extensions/localization.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/chat_top_bar_section/chat_top_bar_section.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/tab_section/chat_tab_bar_section.dart';

class ChatMainTabPage extends StatelessWidget {
  const ChatMainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: ChatTopBarSection(
        localizations: l10n!,
      ),
      body: DefaultTabController(
        length: 2,
        child: ChatTabBarSection(
          localizations: l10n,
        ),
      ),
    );
  }
}
