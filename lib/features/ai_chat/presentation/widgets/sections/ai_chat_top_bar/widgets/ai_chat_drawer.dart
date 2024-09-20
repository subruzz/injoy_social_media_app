
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/dialog/app_dialogs.dart';
import 'package:social_media_app/features/ai_chat/presentation/cubits/cubit/ai_chat_cubit.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/common/ai_profile.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_chat_top_bar/widgets/ai_drawer_header.dart';

class AiChatDrawer extends StatelessWidget {
  const AiChatDrawer({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppDarkColor().secondaryBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          AiDrawerHeader(
            l10n: l10n,
          ),
          DrawerItem(
              title: l10n.newChat,
              asset: AppAssetsConst.newIcon,
              onTap: () {
                context.read<AiChatCubit>().clearChat();
                Navigator.of(context).pop();
              }),

          // DrawerItem(
          //     title: 'New Chat', asset: AppAssetsConst.chat, onTap: () {}),
          DrawerItem(
              title: l10n.aboutInaya,
              asset: AppAssetsConst.about,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AppInfoOnlyDialog(
                      title: l10n.chatAssistant,
                      subTitle: l10n.aboutInayaSubtitle,
                      topHead: const AiProfile(),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.title,
      required this.asset,
      required this.onTap});
  final String title;
  final String asset;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CommonListTile(
      text: title,
      onTap: onTap,
      iconSize: 22,
      leading: asset,
      titileStyle: Theme.of(context).textTheme.titleMedium,
    );
  }
}
