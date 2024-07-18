import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/personal_chat_top_bar/personal_page_top_bar.dart';

class PersonChatPage extends StatefulWidget {
  const PersonChatPage({super.key});

  @override
  State<PersonChatPage> createState() => _PersonChatPageState();
}

class _PersonChatPageState extends State<PersonChatPage> {
  final TextEditingController _textMsgController = TextEditingController();
  final ValueNotifier<bool> _isTextMsgEmpty = ValueNotifier(false);
  final ValueNotifier<bool> _showAttachWindow = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersonalPageTopBar(),
      body: GestureDetector(
        onTap: () {
          _showAttachWindow.value = false;
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/bg.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    _messageLayout(
                        message: 'Helo',
                        alignment: Alignment.centerRight,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageBgColor: AppDarkColor().buttonBackground,
                        onLongPress: () {},
                        onSwipe: () {}),
                    _messageLayout(
                        message: 'helo myra sugano',
                        alignment: Alignment.centerRight,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageBgColor: AppDarkColor().buttonBackground,
                        onLongPress: () {},
                        onSwipe: () {}),
                    _messageLayout(
                        message: 'Helo',
                        alignment: Alignment.centerLeft,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageBgColor: AppDarkColor().secondaryBackground,
                        onLongPress: () {},
                        onSwipe: () {}),
                    _messageLayout(
                        message: 'helo myra sugano',
                        alignment: Alignment.centerLeft,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageBgColor: AppDarkColor().secondaryBackground,
                        onLongPress: () {},
                        onSwipe: () {}),
                  ],
                )),
                Container(
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppDarkColor().secondaryBackground,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        height: 50,
                        child: TextField(
                          onChanged: (value) {
                            if (_showAttachWindow.value) {
                              _showAttachWindow.value = false;
                            }
                            _isTextMsgEmpty.value = value.isNotEmpty;
                          },
                          controller: _textMsgController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: AppDarkColor().iconSoftColor,
                              ),
                              filled: false,
                              hintText: 'Message',
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, top: 10),
                                child: Wrap(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          _showAttachWindow.value =
                                              !_showAttachWindow.value;
                                        },
                                        child: const Icon(
                                            Icons.attach_file_outlined)),
                                    AppSizedBox.sizedBox15W,
                                    const Icon(Icons.camera_alt_outlined)
                                  ],
                                ),
                              ),
                              focusedBorder: InputBorder.none),
                        ),
                      )),
                      AppSizedBox.sizedBox5W,
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppDarkColor().buttonBackground,
                        ),
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _isTextMsgEmpty,
                            builder: (context, value, child) {
                              return Icon(
                                  value ? Icons.send_outlined : Icons.mic);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
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
            )
          ],
        ),
      ),
    );
  }

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

  _messageLayout(
      {Color? messageBgColor,
      Alignment? alignment,
      Timestamp? createAt,
      VoidCallback? onSwipe,
      String? message,
      String? messageType,
      bool? isShowTick,
      bool? isSeen,
      VoidCallback? onLongPress,
      // MessageReplayEntity? reply,
      double? rightPadding}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          alignment: alignment,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        EdgeInsets.only(left: 5, right: 85, top: 5, bottom: 5),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.80),
                    decoration: BoxDecoration(
                        color: messageBgColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      message ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(

                    //             decoration: BoxDecoration(
                    //               color: Colors.black.withOpacity(.2),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             child: Row(
                    //               children: [
                    //                 Container(
                    //                   height: double.infinity,
                    //                   width: 4.5,
                    //                   decoration: BoxDecoration(
                    //                       color: reply.username ==
                    //                               widget.message.recipientName
                    //                           ? Colors.deepPurpleAccent
                    //                           : tabColor,
                    //                       borderRadius:
                    //                           const BorderRadius.only(
                    //                               topLeft:
                    //                                   Radius.circular(15),
                    //                               bottomLeft:
                    //                                   Radius.circular(15))),
                    //                 ),
                    //                 Expanded(
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.symmetric(
                    //                         horizontal: 5.0, vertical: 5),
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           "${reply.username == widget.message.recipientName ? reply.username : "You"}",
                    //                           style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                               color: reply.username ==
                    //                                       widget.message
                    //                                           .recipientName
                    //                                   ? Colors
                    //                                       .deepPurpleAccent
                    //                                   : tabColor),
                    //                         ),
                    //                         MessageReplayTypeWidget(
                    //                           message: reply.message,
                    //                           type: reply.messageType,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //     const SizedBox(
                    //       height: 3,
                    //     ),
                    //     MessageTypeWidget(
                    //       message: message,
                    //       type: messageType,
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text('9/3/4',
                        style: AppTextTheme
                            .bodysmallPureWhiteVariations.bodySmall),
                    const SizedBox(
                      width: 5,
                    ),
                    isShowTick == true
                        ? Icon(
                            isSeen == true ? Icons.done_all : Icons.done,
                            size: 16,
                            color: AppDarkColor().primaryText,
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
