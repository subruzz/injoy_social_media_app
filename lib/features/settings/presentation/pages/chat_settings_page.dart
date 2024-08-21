import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/dialog/app_info_dialog.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/common_switch.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat/chat_cubit.dart';

import '../../../../core/const/enums/media_picker_type.dart';
import '../../../../core/widgets/app_related/app_padding.dart';

class ChatSettingsPage extends StatelessWidget {
  const ChatSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n!.chatSettings,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: CustomAppPadding(
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
              text: l10n.changeChatBackground,
            ),
            const CustomDivider(),
            CommonListTile(
              onTap: () {
                AppInfoDialog.showInfoDialog(
                    title: l10n.areYouSure,
                    subtitle: l10n.clearChatHistory,
                    context: context,
                    callBack: () {
                      context.read<ChatCubit>().deleteMyChats(
                          myId: context.read<AppUserBloc>().appUser.id);
                    },
                    buttonText: l10n.clear);
              },
              text: l10n.clearAllChats,
            ),
            const CustomDivider(),
            CommonListTile(
              removePaddingRight: true,
              onTap: () {},
              text: l10n.showLastSeen,
              trailing: CommonSwitch(value: true, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
