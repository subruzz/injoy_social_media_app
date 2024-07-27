import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/common_empty_holder.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat/chat_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/chat_call_item.dart';

class ChatMessageTabView extends StatelessWidget {
  const ChatMessageTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatFailure) {
          return const Center(
            child: AppErrorGif(),
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
              child: CommonEmptyHolder(asset: AppAssetsConst.nochatHolder,message: 'No chats found',),
            );
          }
          return ListView.builder(
            itemCount: state.chatItems.length,
            itemBuilder: (context, index) {
              return ChatCallItem(
                chat: state.chatItems[index],
                name: state.chatItems[index].recipientName,
                time: state.chatItems[index].recentTextMessage,
              );
            },
          );
        }
        return const EmptyDisplay();
      },
    );
  }
}
