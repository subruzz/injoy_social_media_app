import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common_switch.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat/chat_cubit.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/enums.dart';

import '../../../../core/widgets/app_related/app_padding.dart';
import '../../domain/entity/ui_entity/ui_consts.dart';

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
        body: CustomAppPadding(
          child: ListView.separated(
              itemBuilder: (context, index) {
                final chatSettings = SettingsUiConst.chatSettings[index];
                return CommonListTile(
                    trailing: chatSettings.chatSettingsType ==
                            ChatSettingsType.showLastSeen
                        ? CommonSwitch(
                          value: true,
                          onChanged: (value) {},
                        )
                        : SettingsUiConst.righArrow,
                    onTap: () {
                      switch (chatSettings.chatSettingsType) {
                        case ChatSettingsType.chatbg:
                          Navigator.pushNamed(
                            context,
                            MyAppRouteConst.mediaPickerRoute,
                            arguments: {
                              'pickerType': MediaPickerType.wallapaper
                            },
                          );

                          break;
                        case null:
                        case ChatSettingsType.clearChat:
                          AppInfoDialog.showInfoDialog(
                              title: 'Are You Sure?',
                              subtitle: 'This will clear all your chat history',
                              context: context,
                              callBack: () {
                                context.read<ChatCubit>().deleteMyChats(
                                    myId:
                                        context.read<AppUserBloc>().appUser.id);
                              },
                              buttonText: 'Clear');
                        case ChatSettingsType.blocked:
                        case ChatSettingsType.showLastSeen:
                      }
                    },
                    text: chatSettings.title);
              },
              separatorBuilder: (context, index) {
                return const CustomDivider();
              },
              itemCount: SettingsUiConst.accountSettings.length),
        ));
  }
}

// Placeholder pages
