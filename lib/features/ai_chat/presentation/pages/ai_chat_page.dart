import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_chat_input/ai_chat_input.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_chat_top_bar/ai_chat_top_bar.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_chat_top_bar/widgets/ai_chat_drawer.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_msg/ai_msg_section.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  late AppUser user;
  @override
  void initState() {
    super.initState();
    user = context.read<AppUserBloc>().appUser;
  }

  final _scrollC = ScrollController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollBottom(first: true));
    return Scaffold(
      endDrawer: const AiChatDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: CustomScrollView(
              controller: _scrollC,
              slivers: [
                const AiChatTopBar(),
                AiMsgSection(scrollB: _scrollBottom)
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AiChatInput(),
          ),
        ],
      ),
    );
  }

  void _scrollBottom({bool first = false}) {
    if (_scrollC.hasClients) {
      final bottomOffset = _scrollC.position.maxScrollExtent +
          MediaQuery.of(context).viewInsets.bottom;
      _scrollC.animateTo(
        bottomOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInCirc,
      );
    }
  }
}
