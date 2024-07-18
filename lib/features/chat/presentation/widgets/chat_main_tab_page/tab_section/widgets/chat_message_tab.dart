import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat/chat_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/chat_call_item.dart';

class ChatMessageTabView extends StatefulWidget {
  const ChatMessageTabView({super.key});

  @override
  State<ChatMessageTabView> createState() => _ChatMessageTabViewState();
}

class _ChatMessageTabViewState extends State<ChatMessageTabView> {
  @override
  void initState() {
    context
        .read<ChatCubit>()
        .getMyChats(myId: context.read<AppUserBloc>().appUser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatFailure) {
          return Center(
            child: Text(state.errorMsg),
          );
        }
        if (state is ChatLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        }
        if (state is ChatLoaded) {
          if (state.chatItems.isEmpty) {
            return const Center(
              child: Text('No chats found'),
            );
          }
          return ListView.builder(
            itemCount: state.chatItems.length,
            itemBuilder: (context, index) {
              return ChatCallItem(
                name: state.chatItems[index].recipientName ?? '',
                time: state.chatItems[index].recentTextMessage ?? '',
                isCall: false,
              );
            },
          );
        }
        return const EmptyDisplay();
      },
    );
  }
}
