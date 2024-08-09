import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/sections/ai_chat_top_bar/widgets/ai_drawer_header.dart';

class AiChatDrawer extends StatelessWidget {
  const AiChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppDarkColor().secondaryBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const AiDrawerHeader(),
          DrawerItem(
              title: 'New Chat', asset: AppAssetsConst.newI, onTap: () {}),
          DrawerItem(
              title: 'Chat History', asset: AppAssetsConst.chat, onTap: () {}),
          // DrawerItem(
          //     title: 'New Chat', asset: AppAssetsConst.chat, onTap: () {}),
          DrawerItem(
              title: 'About Inaya', asset: AppAssetsConst.about, onTap: () {}),
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
    return ListTile(
        leading: CustomSvgIcon(
          height: 22,
          width: 22,
          assetPath: asset,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: onTap);
  }
}
