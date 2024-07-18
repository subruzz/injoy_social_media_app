import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/chat_call_item.dart';

class ChatMessageTabView extends StatelessWidget {
  const ChatMessageTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const ChatCallItem(
          name: 'Kathryn',
          time: 'Hey, how are yo',
          isCall: false,
        );
      },
    );
  }
}
