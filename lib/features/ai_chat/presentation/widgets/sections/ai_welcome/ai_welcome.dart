import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/common/ai_gradeitn_text.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/common/ai_profile.dart';

import '../../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';

class AiWelcome extends StatelessWidget {
  final String imagePath;
  final AppLocalizations l10n;
  const AiWelcome({
    super.key,
    required this.imagePath,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AiProfile(),
        AppSizedBox.sizedBox10H,
        if (isThatMobile)
          AiGradientText(
              text: l10n.helloUser(
                  context.read<AppUserBloc>().appUser.userName ?? '')),
        if (isThatMobile) AppSizedBox.sizedBox5H,
        if (isThatMobile) AiGradientText(text: l10n.chatAssistant),
      ],
    ));
  }
}
