import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/chat_top_bar_section/chat_top_bar_section.dart';

import '../widgets/chat_main_tab_page/sections/tab_section/widgets/chat_message_tab.dart';

class ChatMainTabPage extends StatelessWidget {
  const ChatMainTabPage({super.key, this.openChat});
  final void Function(String id)? openChat;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
        appBar: ChatTopBarSection(
          localizations: l10n!,
        ),
        body: ChatMessageTabView(
          openChat: openChat,
        ));
  }
}
