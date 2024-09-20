import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/widgets/common/empty_display.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_bottom_input_bar/chat_input_bar_section.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_bottom_input_bar/widgets/chat_send_button.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/chat_listing_section_section.dart';

import '../../../../core/utils/di/di.dart';
import '../cubits/messages_cubits/message/message_cubit.dart';
import '../widgets/person_chat_page/sections/personal_chat_top_bar/personal_page_top_bar.dart';

class PersonChatPage extends StatefulWidget {
  const PersonChatPage({
    super.key,
    required this.otherUserId,
    required this.myId,
  });
  final String otherUserId;
  final String myId;
  @override
  State<PersonChatPage> createState() => _PersonChatPageState();
}

class _PersonChatPageState extends State<PersonChatPage> {
  bool isRecording = false;
  final TextEditingController _textMsgController = TextEditingController();
  final ValueNotifier<bool> _toggleButton = ValueNotifier(true);
  final ValueNotifier<bool> _showAttachWindow = ValueNotifier(false);
  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom({bool first = false}) {
    if (_scrollController.hasClients) {
      final bottomOffset = _scrollController.position.maxScrollExtent +
          MediaQuery.of(context).viewInsets.bottom;
      _scrollController.animateTo(
        bottomOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  final ValueNotifier<List<MessageEntity>> _selectedMessages =
      ValueNotifier([]);

  final _getMessageCubit = serviceLocator<GetMessageCubit>();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _textMsgController.dispose();
    _toggleButton.dispose();
    _showAttachWindow.dispose();
    _scrollController.dispose();
    _selectedMessages.dispose();
    _getMessageCubit.close();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getMessageCubit.setRecipientMessageUserDetails(
        widget.myId, widget.otherUserId);
  }

  void _handleDateChange(String date) {
    log(date);
    log('Selected date: $date');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // top bar section ----> (online status ,name..)
      appBar: PersonalPageTopBar(
        selectedMessages: _selectedMessages,
        getMessageCubit: _getMessageCubit,
      ),
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();

          _showAttachWindow.value = false;
        },
        child: Stack(
          children: [
            BlocBuilder<ChatWallapaperCubit, ChatWallapaperState>(
              builder: (context, state) {
                return state is ChatWallapaperSuccess
                    ? Positioned.fill(
                        child: Image.file(
                          File(
                            state.wallapaperPath,
                          ),
                          fit: BoxFit.cover,
                        ),
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
                    focusNode: _focusNode,
                    selectedMessages: _selectedMessages,
                    getMessageCubit: _getMessageCubit,
                    onmessageDateChange: _handleDateChange,
                    myid: widget.myId,
                    onSwipe: (message) {
                      onMessageSwipe(message: message);
                    },
                    goToBottom: _scrollToBottom,
                    scrollController: _scrollController),
                //input field for creating chat
                BlocBuilder<GetMessageCubit, GetMessageState>(
                  buildWhen: (previous, current) =>
                      current.statusInfo?.isBlockedByMe == true ||
                      current.statusInfo?.isBlockedByMe == false ||
                      current.statusInfo?.isBlockedByMe == null,
                  bloc: _getMessageCubit,
                  builder: (context, state) {
                    log('stat is f ths ${state.statusInfo?.isBlockedByMe}');
                    return state.statusInfo?.isBlockedByMe == null
                        ? ChatInputBarSection(
                            getMessageCubit: _getMessageCubit,
                            focusNode: _focusNode,
                            messageController: _textMsgController,
                            showAttachWindow: _showAttachWindow,
                            sendMessage: () {
                              _sendTextMsg();
                            },
                            toggleButton: _toggleButton)
                        : state.statusInfo?.isBlockedByMe == true
                            ? Text('You have blocked this user.')
                            : Text('You have been blocked by this user.');
                  },
                ),
              ],
            ),
            BlocBuilder<GetMessageCubit, GetMessageState>(
              buildWhen: (previous, current) =>
                  current.statusInfo?.isBlockedByMe == true ||
                  current.statusInfo?.isBlockedByMe == false ||
                  current.statusInfo?.isBlockedByMe == null,
              bloc: _getMessageCubit,
              builder: (context, state) {
                return state.statusInfo?.isBlockedByMe == null
                    ? ChatSendButton(
                        getMessageState: _getMessageCubit,
                        toggleButton: _toggleButton,
                        sendMessage: () {
                          _sendTextMsg();
                        },
                        messageController: _textMsgController,
                      )
                    : const EmptyDisplay();
              },
            ),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: DateHeader(
            //     date: DateTime.now().toFormattedString(),
            //   ),
            // )
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
    final messageCubit = context.read<MessageCubit>();
    if (type == MessageTypeConst.textMessage) {
      messageCubit.sendMessage(
          messageState: _getMessageCubit.state,
          recentTextMessage: message,
          messageType: type,
          captions: []);
    } else if (type == MessageTypeConst.audioMessage) {
      messageCubit.voiceRecordStopped(_getMessageCubit.state);
    }
  }
}

class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Text(
        date,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}
