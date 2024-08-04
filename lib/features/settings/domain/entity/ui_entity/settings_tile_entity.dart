import 'package:flutter/material.dart';

import 'enums.dart';

class SettingsTileEntity {
  final String title;
  final String? subTitle;
  final String? leading;
  final Widget? trailing;
  final AccountSettingsType? accountSettingType;
  final NotificationPreferenceEnum? notificationSettingsType;
  final ChatSettingsType? chatSettingsType;
  SettingsTileEntity(
      {required this.title,
      this.subTitle,
      this.chatSettingsType,
      this.accountSettingType,
      this.notificationSettingsType,
      this.leading,
      this.trailing});
}
