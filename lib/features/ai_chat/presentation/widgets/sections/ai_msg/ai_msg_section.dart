import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/features/ai_chat/presentation/cubits/cubit/ai_chat_cubit.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_msg/widgets/ai_chat_bubble.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_msg/widgets/ai_generating_shimmer.dart';

import '../../../../../../core/widgets/messenger/messenger.dart';
import '../../../../../../core/widgets/app_related/empty_display.dart';
import '../ai_welcome/ai_welcome.dart';

class AiMsgSection extends StatelessWidget {
  const AiMsgSection({super.key, required this.scrollB, required this.l10n});
  final VoidCallback scrollB;
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiChatCubit, AiChatState>(
      builder: (context, state) {
    
        if (state.chatMessages.isEmpty && !state.isLoading) {
          return SliverToBoxAdapter(
            child: AiWelcome(
              l10n: l10n,
              imagePath: AppAssetsConst.ai,
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < state.chatMessages.length) {
                final chat = state.chatMessages[index];
                return AiChatBubble(
                  text: chat.parts.first.text,
                  isSentByMe: chat.role == 'user',
                );
              } else if (state.isLoading) {
                return const AiGeneratingShimmer();
              }
              return const EmptyDisplay();
            },
            childCount: state.isLoading
                ? state.chatMessages.length + 1
                : state.chatMessages.length,
          ),
        );
      },
      listener: (context, state) {
        scrollB();
        if (state.isError) {
          Messenger.showSnackBar(message: l10n.errorGeneratingResponse);
        }
      },
    );
  }
}
