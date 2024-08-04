import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/features/settings/presentation/pages/account_settings/account_settings_page.dart';
import 'package:social_media_app/features/settings/presentation/pages/chat_settings_page.dart';
import 'package:social_media_app/features/settings/presentation/pages/notification_preference_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    final appuser = context.read<AppUserBloc>().appUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // SettingsTile(
          //     icon: Icons.person_add, title: 'Follow and Invite Friends'),
          SettingsTile(
            icon: Icons.account_circle,
            title: 'Account',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AccountSettingsPage(
                        appUser: appuser,
                      )),
            ),
          ),

          SettingsTile(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationPreferenceScreen(),
                  ))),
          SettingsTile(
              icon: Icons.chat,
              title: 'Chat',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatSettingsPage(),
                  ))),
          SettingsTile(
            icon: Icons.lock,
            title: 'Privacy',
            onTap: () {
              // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('myChat').
            },
          ),
          SettingsTile(icon: Icons.security, title: 'Security'),
          SettingsTile(icon: Icons.help, title: 'Help'),
          SettingsTile(icon: Icons.info, title: 'About'),
          SwitchListTile(
            title: Text('Dark Theme'),
            secondary: Icon(Icons.brightness_6),
            value: isDarkTheme,
            onChanged: (value) {
              setState(() {
                isDarkTheme = value;
              });
            },
          ),
          const CustomDivider()
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  SettingsTile({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
