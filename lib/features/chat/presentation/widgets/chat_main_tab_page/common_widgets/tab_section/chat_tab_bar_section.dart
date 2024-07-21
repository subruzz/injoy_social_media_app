import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/tab_section/widgets/chat_calls_tab.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/sections/tab_section/widgets/chat_message_tab.dart';

class ChatTabBarSection extends StatelessWidget {
  const ChatTabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
         TabBar(
          tabs: <Widget>[
            Tab(text: 'Messages'),
            Tab(text: 'Calls'),
          ],
        ),
        Expanded(
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
