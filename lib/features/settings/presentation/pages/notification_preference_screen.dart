import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/widgets/common/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/common_switch.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/ui_consts.dart';
import 'package:social_media_app/features/settings/presentation/cubit/settings/settings_cubit.dart';

import '../../../../core/widgets/loading/circular_loading.dart';
import '../../domain/entity/ui_entity/enums.dart';

class NotificationPreferenceScreen extends StatefulWidget {
  const NotificationPreferenceScreen({super.key});
  @override
  State<NotificationPreferenceScreen> createState() =>
      _NotificationPreferenceScreenState();
}

class _NotificationPreferenceScreenState
    extends State<NotificationPreferenceScreen> {
  late NotificationPreferences _notificationPreferences;
  late String myId;
  @override
  void initState() {
    final me = context.read<AppUserBloc>().appUser;
    _notificationPreferences = me.notificationPreferences;

    myId = me.id;
    super.initState();
  }

  void editNotification(
      NotificationPreferenceEnum notificationPreferenceType, bool val) {
    context.read<SettingsCubit>().editNotificationPreference(
        value: val,
        notificationPreferenceType: notificationPreferenceType,
        notificatonPreferernce: _notificationPreferences,
        myid: myId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppCustomAppbar(
        title: l10n!.notifications,
      ),
      body: CustomAppPadding(
        child: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is NotifiationPreferenceError) {}
          },
          builder: (context, state) {
            return Stack(
              children: [
                CustomAppPadding(
                  child: ListView(
                    children: [
                      ListTileForNotificationSettings(
                          title: l10n.pause_all,
                          subTitle: l10n.pause_all_subtitle,
                          value: _notificationPreferences.isNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.pauseAll, value);
                          }),
                      ListTileForNotificationSettings(
                          title: l10n.likes,
                          subTitle: l10n.likes_subtitle,
                          value:
                              _notificationPreferences.isLikeNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.likes, value);
                          }),
                      ListTileForNotificationSettings(
                          title: l10n.follow,
                          subTitle: l10n.follow_subtitle,
                          value: _notificationPreferences
                              .isFollowNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.follow, value);
                          }),
                      ListTileForNotificationSettings(
                          title: l10n.comments,
                          subTitle: l10n.comments_subtitle,
                          value: _notificationPreferences
                              .isCommentNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.comments, value);
                          }),
                      ListTileForNotificationSettings(
                          title: l10n.messages,
                          subTitle: l10n.messages_subtitle,
                          value: _notificationPreferences
                              .isMessageNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.messages, value);
                          }),
                    ],
                  ),
                ),
                // CustomAppPadding(
                //     child: ListView.builder(
                //   itemCount: SettingsUiConst.notificationSettings.length,
                //   itemBuilder: (context, index) {
                //     final notificationSettings =
                //         SettingsUiConst.notificationSettings[index];
                //     return CommonListTile(
                //       noPadding: true,
                //       text: notificationSettings.title,
                //       subtitle: notificationSettings.subTitle,
                //       trailing: CommonSwitch(
                //         value: _getCurrentNotificationValue(
                //             notificationSettings.notificationSettingsType!),
                //         onChanged: (value) {
                //           editNotification(
                //               notificationSettings.notificationSettingsType!,
                //               value);
                //         },
                //       ),
                //     );
                //   },
                // )),
                if (state is NotifiationPreferenceLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularLoadingGrey(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _getCurrentNotificationValue(NotificationPreferenceEnum type) {
    switch (type) {
      case NotificationPreferenceEnum.pauseAll:
        return _notificationPreferences.isNotificationPaused;
      case NotificationPreferenceEnum.likes:
        return _notificationPreferences.isLikeNotificationPaused;
      case NotificationPreferenceEnum.follow:
        return _notificationPreferences.isFollowNotificationPaused;
      case NotificationPreferenceEnum.comments:
        return _notificationPreferences.isCommentNotificationPaused;
      case NotificationPreferenceEnum.messages:
        return _notificationPreferences.isMessageNotificationPaused;
      default:
        return false;
    }
  }
}

class ListTileForNotificationSettings extends StatelessWidget {
  const ListTileForNotificationSettings(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.value,
      required this.onChanged});
  final String title;
  final String subTitle;
  final bool value;
  final void Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return CommonListTile(
      noPadding: true,
      text: title,
      subtitle: subTitle,
      trailing: CommonSwitch(value: value, onChanged: onChanged),
    );
  }
}
