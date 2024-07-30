import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common_switch.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';
import 'package:social_media_app/features/settings/domain/repository/settings_repository.dart';
import 'package:social_media_app/features/settings/presentation/cubit/settings/settings_cubit.dart';

import '../../../../core/widgets/loading/circular_loading.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: CustomAppPadding(
        child: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is NotifiationPreferenceError) {
              log('state is eerror');
              // _notificationPreferences = state.notificationPreferences;
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Push notification',
                        style: Theme.of(context).textTheme.titleMedium),
                    const CustomDivider(),
                    CommonListTile(
                        subtitle: 'Pause all notifications',
                        text: 'Pause all',
                        trailing: CommonSwitch(
                          value: _notificationPreferences.isNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.pauseAll, value);
                          },
                        )),
                    CommonListTile(
                        subtitle: 'Pauses the notification of post likes',
                        text: 'Likes',
                        trailing: CommonSwitch(
                          value:
                              _notificationPreferences.isLikeNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.likes, value);
                          },
                        )),
                    CommonListTile(
                        text: 'Follow',
                        subtitle:
                            'Pauses the notification when someone follows you',
                        trailing: CommonSwitch(
                          value: _notificationPreferences
                              .isFollowNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.follow, value);
                          },
                        )),
                    CommonListTile(
                        text: 'Comments',
                        subtitle: 'Pauses the notification of post comments',
                        trailing: CommonSwitch(
                          value: _notificationPreferences
                              .isCommentNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.comments, value);
                          },
                        )),
                    CommonListTile(
                        subtitle:
                            'Pauses the notification when a new message arrives',
                        text: 'Messages',
                        trailing: CommonSwitch(
                          value: _notificationPreferences
                              .isMessageNotificationPaused,
                          onChanged: (value) {
                            editNotification(
                                NotificationPreferenceEnum.messages, value);
                          },
                        ))
                  ],
                ),
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
}
