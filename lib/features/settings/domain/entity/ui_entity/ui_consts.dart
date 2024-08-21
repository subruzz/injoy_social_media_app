import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/enums.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/settings_tile_entity.dart';

class SettingsUiConst {
  const SettingsUiConst._();
  static const Icon righArrow = Icon(
    Icons.arrow_forward_ios,
    size: 20,
  );
  static List<SettingsTileEntity> accountSettings = [
    SettingsTileEntity(
        title: 'Change Username',
        accountSettingType: AccountSettingsType.changeUserName,
        leading: AppAssetsConst.person,
        trailing: righArrow),
    // SettingsTileEntity(
    //     title: 'Change Email',
    //     accountSettingType: AccountSettingsType.changeMail,
    //     leading: AppAssetsConst.email,
    //     trailing: righArrow),
    // SettingsTileEntity(
    //     title: 'Change Password',
    //     accountSettingType: AccountSettingsType.changePassword,
    //     leading: AppAssetsConst.lock,
    //     trailing: righArrow),
    SettingsTileEntity(
        title: 'Delete Account',
        accountSettingType: AccountSettingsType.deleteAccount,
        leading: AppAssetsConst.delete,
        trailing: righArrow)
  ];

  static List<SettingsTileEntity> notificationSettings = [
    SettingsTileEntity(
      title: 'Pause All',
      subTitle: 'Pause all notifications',
      notificationSettingsType: NotificationPreferenceEnum.pauseAll,
    ),
    SettingsTileEntity(
      title: 'Likes',
      subTitle: 'Pauses the notification of post likes',
      notificationSettingsType: NotificationPreferenceEnum.likes,
    ),
    SettingsTileEntity(
      title: 'Follow',
      subTitle: 'Pauses the notification when someone follows you',
      notificationSettingsType: NotificationPreferenceEnum.follow,
    ),
    SettingsTileEntity(
      title: 'Comments',
      subTitle: 'Pauses the notification of post comments',
      notificationSettingsType: NotificationPreferenceEnum.comments,
    ),
    SettingsTileEntity(
      title: 'Message',
      subTitle: 'Pauses the notification when a new message arrives',
      notificationSettingsType: NotificationPreferenceEnum.messages,
    ),
  ];
  static List<SettingsTileEntity> chatSettings = [
    SettingsTileEntity(
      title: 'Change Chat Background',
      chatSettingsType: ChatSettingsType.chatbg,
    ),
    SettingsTileEntity(
      title: 'Clear All Chats',
      chatSettingsType: ChatSettingsType.clearChat,
    ),
    SettingsTileEntity(
      title: 'Blocked Contacts',
      chatSettingsType: ChatSettingsType.blocked,
    ),
    SettingsTileEntity(
      title: 'Show Last Seen',
      chatSettingsType: ChatSettingsType.showLastSeen,
    )
  ];
}
