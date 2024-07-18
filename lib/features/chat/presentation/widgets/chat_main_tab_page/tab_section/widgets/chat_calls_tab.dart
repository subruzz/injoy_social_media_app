import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/chat_call_item.dart';

class ChatCallsTabView extends StatelessWidget {
  const ChatCallsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const ChatCallItem(
          name: 'Kathryn',
          time: '16:47 30 May',
          isCall: true,
        );
      },
    );
  }
}
