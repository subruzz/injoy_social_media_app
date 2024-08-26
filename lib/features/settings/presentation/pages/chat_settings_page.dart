import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/core/widgets/common/overlay_loading_holder.dart';
import 'package:social_media_app/core/widgets/dialog/app_info_dialog.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/common/common_list_tile.dart';
import 'package:social_media_app/core/widgets/common/common_switch.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/settings/presentation/cubit/settings/settings_cubit.dart';

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
      body: BlocConsumer<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) =>
            current is ClearChatFailed ||
            current is ClearChatSuccess ||
            current is ClearChatLoading,
        listenWhen: (previous, current) =>
            current is ClearChatFailed ||
            current is ClearChatSuccess ||
            current is ClearChatLoading,
        listener: (context, state) {
          if (state is ClearChatFailed) {
            Messenger.showSnackBar(
                message:
                    'An error occured while clearing all chats,please try again!');
          }
          if (state is ClearChatSuccess) {
            Messenger.showSnackBar(
                message: 'Your chat history has been cleared');
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              CustomAppPadding(
                child: ListView(children: [
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
                          subtitle: l10n.clear_history_message,
                          context: context,
                          callBack: () {
                            context.read<SettingsCubit>().clearAllChats(
                                context.read<AppUserBloc>().appUser.id);
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
                      trailing: ChatLastSeenSettings(
                        l10n: l10n,
                      )),
                ]),
              ),
              if (state is ClearChatLoading) const OverlayLoadingHolder()
            ],
          );
        },
      ),
    );
  }
}

class ChatLastSeenSettings extends StatefulWidget {
  const ChatLastSeenSettings({
    super.key,
    required this.l10n,
  });
  final AppLocalizations l10n;
  @override
  State<ChatLastSeenSettings> createState() => _ChatLastSeenSettingsState();
}

class _ChatLastSeenSettingsState extends State<ChatLastSeenSettings> {
  late bool _isShowLastSeen;
  late AppUser appUser;
  @override
  void initState() {
    appUser = context.read<AppUserBloc>().appUser;
    _isShowLastSeen = appUser.showLastSeen;
    super.initState();
  }

  //it is better to separate ui and backend code
  //for simplicity i did this
  void changeLastSeenSettings(bool val) async {
    try {
      await serviceLocator<FirebaseHelper>()
          .updateUserLastSeen(appUser.id, val);
      appUser.showLastSeen = _isShowLastSeen;
    } catch (e) {
      Messenger.showSnackBar(message: widget.l10n.change_settings_error);
      setState(() {
        _isShowLastSeen = !_isShowLastSeen;
        appUser.showLastSeen = _isShowLastSeen;
      });
    }
  }

  void changeTheVal(bool value) {
    setState(() {
      _isShowLastSeen = !_isShowLastSeen;
      changeLastSeenSettings(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonSwitch(
        value: _isShowLastSeen,
        onChanged: (value) {
          !value
              ? AppInfoDialog.showInfoDialog(
                  title: widget.l10n.areYouSure,
                  subtitle: widget.l10n.turning_it_off_prevent_seeing_last_seen,
                  context: context,
                  callBack: () {
                    changeTheVal(value);
                  },
                  buttonText: widget.l10n.ok)
              : changeTheVal(value);
        });
  }
}
