import 'package:flutter/material.dart';
import 'package:social_media_app/core/extensions/localization.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/tab_section/widgets/chat_calls_tab.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/tab_section/widgets/chat_message_tab.dart';

class ChatTabBarSection extends StatelessWidget {
  const ChatTabBarSection({super.key, required this.localizations});
  final AppLocalizations localizations;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          tabs: <Widget>[
            Tab(text: localizations.message),
            Tab(text: localizations.calls),
          ],
        ),
        const Expanded(
          child: TabBarView(
            children: <Widget>[
              ChatMessageTabView(),
              ChatCallsTabView(),
            ],
          ),
        ),
      ],
    );
  }
}
