import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_bottom_input_bar/chat_input_bar_section.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_bottom_input_bar/widgets/chat_send_button.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/chat_listing_section_section.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/personal_chat_top_bar/personal_page_top_bar.dart';

class PersonChatPage extends StatefulWidget {
  const PersonChatPage({
    super.key,
  });

  @override
  State<PersonChatPage> createState() => _PersonChatPageState();
}

class _PersonChatPageState extends State<PersonChatPage> {
  bool isRecording = false;
  final TextEditingController _textMsgController = TextEditingController();
  final ValueNotifier<bool> _toggleButton = ValueNotifier(false);
  final ValueNotifier<bool> _showAttachWindow = ValueNotifier(false);
  final ScrollController _scrollController = ScrollController();
  Future<void> _scrollToBottom() async {
    if (_scrollController.hasClients) {
      await Future.delayed(const Duration(milliseconds: 100));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  final FocusNode _focusNode = FocusNode();
  late MessageInfoStoreCubit _msgInfo;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    _msgInfo = context.read<MessageInfoStoreCubit>();
    context.read<MessageCubit>().getPersonalChats(
        recipientId: _msgInfo.receiverId,
        sendorId: context.read<AppUserBloc>().appUser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // top bar section ----> (online status ,name..)
      appBar: PersonalPageTopBar(
        id: _msgInfo.receiverId,
        userName: _msgInfo.receiverName,
      ),
      body: GestureDetector(
        onTap: () {
          _showAttachWindow.value = false;
        },
        child: Stack(
          children: [
            BlocBuilder<ChatWallapaperCubit, ChatWallapaperState>(
              builder: (context, state) {
                return state is ChatWallapaperSuccess
                    ? Image.file(
                        File(
                          state.wallapaperPath,
                        ),
                        fit: BoxFit.cover,
                      )
                    : Positioned.fill(
                        child: Image.asset(
                          'assets/images/bg.jpeg',
                          fit: BoxFit.cover,
                        ),
                      );
              },
            ),
            Column(
              children: [
                //messages listing
                ChatListingSectionSection(
                    onSwipe: (message) {
                      onMessageSwipe(message: message);
                    },
                    goToBottom: _scrollToBottom,
                    scrollController: _scrollController),
                //input field for creating chat
                ChatInputBarSection(
                    focusNode: _focusNode,
                    messageController: _textMsgController,
                    showAttachWindow: _showAttachWindow,
                    sendMessage: () {
                      _sendTextMsg();
                    },
                    toggleButton: _toggleButton),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _showAttachWindow,
              builder: (context, value, child) {
                return value
                    ? Positioned(
                        bottom: 65,
                        top: 280,
                        left: 15,
                        right: 15,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.20,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _attachWindowItem(
                                    icon: Icons.document_scanner,
                                    color: Colors.deepPurpleAccent,
                                    title: "Document",
                                  ),
                                  _attachWindowItem(
                                      icon: Icons.camera_alt,
                                      color: Colors.pinkAccent,
                                      title: "Camera",
                                      onTap: () {}),
                                  _attachWindowItem(
                                      icon: Icons.image,
                                      color: Colors.purpleAccent,
                                      title: "Gallery"),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _attachWindowItem(
                                      icon: Icons.headphones,
                                      color: Colors.deepOrange,
                                      title: "Audio"),
                                  _attachWindowItem(
                                      icon: Icons.location_on,
                                      color: Colors.green,
                                      title: "Location"),
                                  _attachWindowItem(
                                      icon: Icons.account_circle,
                                      color: Colors.deepPurpleAccent,
                                      title: "Contact"),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _attachWindowItem(
                                    icon: Icons.bar_chart,
                                    color: Colors.green,
                                    title: "Poll",
                                  ),
                                  _attachWindowItem(
                                      icon: Icons.gif_box_outlined,
                                      color: Colors.indigoAccent,
                                      title: "Gif",
                                      onTap: () {
                                        // _sendGifMessage();
                                      }),
                                  _attachWindowItem(
                                      icon: Icons.videocam_rounded,
                                      color: Colors.lightGreen,
                                      title: "Video",
                                      onTap: () {
                                        // selectVideo().then((value) {
                                        //   if (_video != null) {
                                        //     WidgetsBinding.instance.addPostFrameCallback(
                                        //       (timeStamp) {
                                        //         showVideoPickedBottomModalSheet(context,
                                        //             recipientName:
                                        //                 widget.message.recipientName,
                                        //             file: _video, onTap: () {
                                        //           _sendVideoMessage();
                                        //           Navigator.pop(context);
                                        //         });
                                        //       },
                                        //     );
                                        //   }
                                        // });
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : EmptyDisplay();
              },
            ),
            ChatSendButton(
              toggleButton: _toggleButton,
              sendMessage: () {
                _sendTextMsg();
              },
              messageController: _textMsgController,
            ),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         top: 10.0), // Optional: Adjust top padding as needed
            //     child: CircularLoadingGrey(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void onMessageSwipe({required MessageEntity message}) {}
  _attachWindowItem(
      {IconData? icon, Color? color, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: color),
            child: Icon(icon),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "$title",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _sendTextMsg() {
    _sendMessage(
        message: _textMsgController.text.trim(),
        type: MessageTypeConst.textMessage);
  }

  void _sendMessage({required String message, required String type}) {
    context.read<MessageCubit>().sendMessage(
        recentTextMessage: message, messageType: type, captions: []);
  }
}
