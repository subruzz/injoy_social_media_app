import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/chat_top_bar_section/chat_top_bar_section.dart';

import '../widgets/chat_main_tab_page/sections/tab_section/widgets/chat_message_tab.dart';

class ChatMainTabPage extends StatefulWidget {
  const ChatMainTabPage({super.key});

  @override
  State<ChatMainTabPage> createState() => _ChatMainTabPageState();
}

class _ChatMainTabPageState extends State<ChatMainTabPage> {
  @override
  void initState() {
    super.initState();
    log('Chat is built ');
  }

  @override
  void dispose() {
    log('Chat is disposed ');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
        appBar: ChatTopBarSection(
          localizations: l10n!,
        ),
        body: const ChatMessageTabView());
  }
}
