import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/chat_top_bar_section/chat_top_bar_section.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/tab_section/chat_tab_bar_section.dart';

class ChatMainTabPage extends StatelessWidget {
  const ChatMainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatTopBarSection(),
      body: DefaultTabController(
        length: 2,
        child: ChatTabBarSection(),
      ),
    );
  }
}
