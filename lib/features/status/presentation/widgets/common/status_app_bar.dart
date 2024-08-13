import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/widgets/app_related/app_bar_common_icon.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';

import '../../../../../core/const/app_config/app_padding.dart';
import '../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../../core/widgets/app_related/rotated_icon.dart';
import '../../../../../core/widgets/loading/circular_loading.dart';

class StatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusAppBar({
    super.key,
    this.colorCubit,
    this.statusController,
    this.isChat = false,
    this.isTextStatus = true,
    this.pageIndex = 0,
    this.suffixPressed,
  });
  final SelectColorCubit? colorCubit;
  final TextEditingController? statusController;
  final bool isTextStatus;
  final bool isChat;
  final int pageIndex;
  final VoidCallback? suffixPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppBar(
      backgroundColor: colorCubit?.color,
      title: Text(
        isChat ? l10n!.sendMedia : l10n!.createStatus,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      leading: const AppBarCommonIcon(
        icon: null,
      ),
      actions: [
        isTextStatus
            ? BlocConsumer<StatusBloc, StatusState>(
                listener: (context, state) {
                  if (state is StatusCreateSuccess) {
                    Navigator.pop(context);
                    Messenger.showSnackBar(message: l10n.statusPostedSuccess);
                  }
                  if (state is StatusCreateFailure) {
                    Messenger.showSnackBar(message: state.errorMsg);
                  }
                },
                builder: (context, state) {
                  if (state is StatusCreateLoading) {
                    return Padding(
                      padding: AppPadding.onlyRightMedium,
                      child: const CircularLoading(),
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      final currentUser = context.read<AppUserBloc>().appUser;
                      context.read<StatusBloc>().add(CreateStatusEvent(
                          userId: currentUser.id,
                          profilePic: currentUser.profilePic,
                          userName: currentUser.userName ?? '',
                          content: statusController?.text.trim(),
                          color: colorCubit!.color.value,
                          statusImage: null));
                    },
                    icon: const RotatedIcon(
                      icon: Icons.send_outlined,
                    ),
                  );
                },
              )
            : IconButton(
                onPressed: () async {
                  suffixPressed?.call();
                },
                icon: const Icon(Icons.crop))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
