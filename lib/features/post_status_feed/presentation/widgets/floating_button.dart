import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import 'package:social_media_app/core/widgets/dialog/dialogs.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/services/app_interal/haptic_feedback.dart';
import 'package:social_media_app/features/ai_chat/presentation/pages/ai_chat_page.dart';

import '../../../../core/const/enums/media_picker_type.dart';
import '../../../../core/utils/routes/page_transitions.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedbackHelper().heavyImpact();
            if (!context.read<AppUserBloc>().appUser.hasPremium) {
              AppDialogsCommon.noPremium(context);
              return;
            }
            Navigator.push(
              context,
              AppPageTransitions.fade(
                const AiChatPage(),
              ),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.pink,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.circle,
                color: Colors.white,
                size: 30,
              ),
            ),
          ).animate().then(duration: const Duration(seconds: 4)).rotate(
              begin: 0, end: 2 * pi, duration: const Duration(seconds: 2)),
        ),
        AppSizedBox.sizedBox15H,
        SpeedDial(
          onOpen: () {
            HapticFeedbackHelper().heavyImpact();
          },
          heroTag: 'heroTag1',
          overlayOpacity: .5,
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            _getHomeFloatingPopupButton(
                context: context,
                name: l10n.shorts,
                type: MediaPickerType.reels),
            _getHomeFloatingPopupButton(
                context: context,
                name: l10n.status,
                type: MediaPickerType.status),
            _getHomeFloatingPopupButton(
                context: context, name: l10n.post, type: MediaPickerType.post),
          ],
        ),
      ],
    );
  }

  SpeedDialChild _getHomeFloatingPopupButton(
      {required BuildContext context,
      required String name,
      required MediaPickerType type}) {
    return SpeedDialChild(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppDarkColor().primaryText),
        onTap: () {
          if (type == MediaPickerType.status) {
            Navigator.pushNamed(context, MyAppRouteConst.statusCreationRoute);
            return;
          }
          Navigator.pushNamed(
            context,
            MyAppRouteConst.mediaPickerRoute,
            arguments: {'pickerType': type},
          );
        },
        child: CustomSvgIcon(
            color: AppDarkColor().primaryText,
            assetPath: type == MediaPickerType.status
                ? AppAssetsConst.story
                : type == MediaPickerType.reels
                    ? AppAssetsConst.shorts
                    : AppAssetsConst.post),
        label: name);
  }
}
