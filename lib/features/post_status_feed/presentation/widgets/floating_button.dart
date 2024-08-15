import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/services/app_interal/haptic_feedback.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/ai_chat_button.dart';
import '../../../../core/const/enums/media_picker_type.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const AiChatButton(),
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
