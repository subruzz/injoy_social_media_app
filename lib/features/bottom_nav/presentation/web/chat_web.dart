import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';
import 'package:social_media_app/features/chat/presentation/pages/chat_main_tab_page.dart';
import 'package:social_media_app/features/chat/presentation/pages/personal_chat_builder.dart';

class ChatWebScreen extends StatefulWidget {
  const ChatWebScreen({super.key});

  @override
  State<ChatWebScreen> createState() => _ChatWebScreenState();
}

class _ChatWebScreenState extends State<ChatWebScreen> {
  String? otherUserID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: ChatMainTabPage(
              openChat: (String userId) {
                setState(() {
                  otherUserID = userId;
                });
              },
            ),
          ),
          const VerticalDivider(
            thickness: 5,
          ),
          Expanded(
            flex: 2,
            child: otherUserID == null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssetsConst.applogo,
                            width: 100,
                          ),
                          AppSizedBox.sizedBox20H,
                          const CustomText(
                              text: 'I N J O Y WEB\nSend and Recieve Messages'),
                        ],
                      ),
                    ),
                  )
                : PersonalChatBuilder(
                    key: ValueKey(otherUserID),
                    otherUserId: otherUserID!,
                  ),
          ),
        ],
      ),
    );
  }
}
