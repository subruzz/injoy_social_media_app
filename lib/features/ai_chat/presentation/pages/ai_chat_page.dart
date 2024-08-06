import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/ai_chat/presentation/cubits/cubit/ai_chat_cubit.dart';
import 'package:flutter/material.dart';

class CustomCircularProfile extends StatelessWidget {
  final String imagePath;
  final String displayName;

  const CustomCircularProfile({
    required this.imagePath,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 130.w,
            height: 120.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.red, Colors.black],
                stops: [0.2, 1.0],
              ),
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          // Greeting text with emoji
          ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              colors: [
                Colors.blue,
                Colors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(rect),
            child: Text(
              'Hello  ${addAtSymbol(context.read<AppUserBloc>().appUser.userName)}!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.h),
          // Introduction text with gradient
          ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              colors: [
                Colors.blue,
                Colors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(rect),
            child: Text(
              'I am Inaya, your chat assistant!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final _scrollC = ScrollController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollBottom(first: true));
    return Scaffold(
      body: Stack(
        children: [
          // This positions the chat messages above the input field
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: CustomScrollView(
              controller: _scrollC,
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: true,
                  elevation: 2,
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  titleSpacing: 0, // Set title spacing to 0 to reduce space
                  title: Row(
                    children: [
                      const CircularUserProfile(
                        wantCustomAsset: true,
                        customAsset: AppAssetsConst.ai,
                        size: 20,
                      ),
                      AppSizedBox.sizedBox10W,
                      Text(
                        'Inaya',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                BlocConsumer<AiChatCubit, AiChatState>(
                  builder: (context, state) {
                    if (state.chatMessages.isEmpty && !state.isLoading) {
                      return SliverToBoxAdapter(
                        child: CustomCircularProfile(
                          imagePath: AppAssetsConst.ai,
                          displayName: 'Inaya',
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index < state.chatMessages.length) {
                            final chat = state.chatMessages[index];
                            return ChatBubble(
                              text: chat.parts.first.text,
                              isSentByMe: chat.role == 'user',
                            );
                          } else if (state.isLoading) {
                            return CustomShimmer();
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
                    _scrollBottom();
                    if (state.isError) {
                      Messenger.showSnackBar(
                          message:
                              'An error occurred while generating the response.');
                    }
                  },
                ),
              ],
            ),
          ),
          // This positions the ChatInputField at the bottom
          const Align(
            alignment: Alignment.bottomCenter,
            child: ChatInputField(),
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

class CustomShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.deepPurple,
      highlightColor: Colors.pinkAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Star Icon
          Icon(Icons.star, size: 24, color: Colors.white),
          SizedBox(height: 8), // Spacing
          // First Shimmer Line
          Container(
            height: 10,
            width: 100,
            color: Colors.white,
          ),
          SizedBox(height: 4), // Spacing
          // Second Shimmer Line
          Container(
            height: 10,
            width: 150,
            color: Colors.white,
          ),
          SizedBox(height: 4), // Spacing
          // Third Shimmer Line
          Container(
            height: 10,
            width: 200,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final String? timestamp;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSentByMe,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (timestamp != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              timestamp!,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: isSentByMe ? Colors.blue : Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: isSentByMe ? Radius.circular(20) : Radius.zero,
              bottomRight: isSentByMe ? Radius.zero : Radius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _aiChatController = TextEditingController();

  @override
  void dispose() {
    _aiChatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                radius: AppBorderRadius.large,
                hintText: 'Type something...',
                controller: _aiChatController,
              ),
            ),
            AppSizedBox.sizedBox10W,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (_aiChatController.text.trim().isEmpty) {
                    return;
                  }
                  context
                      .read<AiChatCubit>()
                      .chatGenerateNewTextMessage(_aiChatController.text);
                  _aiChatController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
