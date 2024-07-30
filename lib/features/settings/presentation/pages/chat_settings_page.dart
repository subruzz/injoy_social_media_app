import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common_switch.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat/chat_cubit.dart';

class ChatSettingsPage extends StatelessWidget {
  const ChatSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat Settings',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CommonListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MyAppRouteConst.mediaPickerRoute,
                  arguments: {'pickerType': MediaPickerType.wallapaper},
                );
              },
              text: 'Change Chat Background',
              icon: Icons.wallpaper,
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const CustomDivider(),
            CommonListTile(
              onTap: () {
                AppInfoDialog.showInfoDialog(
                    title: 'Are You Sure?',
                    subtitle: 'This will clear all your chat history',
                    context: context,
                    callBack: () {
                      context.read<ChatCubit>().deleteMyChats(
                          myId: context.read<AppUserBloc>().appUser.id);
                    },
                    buttonText: 'Clear');
              },
              text: 'Clear All Chats',
              icon: Icons.clear_all,
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const CustomDivider(),
            const CommonListTile(
                text: 'Blocked Contacts',
                icon: Icons.block,
                trailing: Icon(Icons.arrow_forward_ios)),
            const CustomDivider(),
            CommonListTile(
              text: 'Show Last Seen',
              icon: Icons.visibility,
              trailing: CommonSwitch(value: true, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages
class ChangeChatBackgroundPage extends StatelessWidget {
  const ChangeChatBackgroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Chat Background'),
      ),
      body: Center(
        child: Text('Change Chat Background Page'),
      ),
    );
  }
}

class ClearAllChatsPage extends StatelessWidget {
  const ClearAllChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clear All Chats'),
      ),
      body: Center(
        child: Text('Clear All Chats Page'),
      ),
    );
  }
}

class ChatNotificationsPage extends StatelessWidget {
  const ChatNotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Notifications'),
      ),
      body: Center(
        child: Text('Chat Notifications Page'),
      ),
    );
  }
}

class ChatPrivacyPage extends StatelessWidget {
  const ChatPrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Privacy'),
      ),
      body: Center(
        child: Text('Chat Privacy Page'),
      ),
    );
  }
}

class BlockedContactsPage extends StatelessWidget {
  const BlockedContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocked Contacts'),
      ),
      body: Center(
        child: Text('Blocked Contacts Page'),
      ),
    );
  }
}
