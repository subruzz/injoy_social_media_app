import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/const/languages/app_languages.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/common/ai_profile.dart';

import '../../../../../../../core/widgets/animation/animations.dart';
import '../../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../common/ai_gradeitn_text.dart';

class AiDrawerHeader extends StatelessWidget {
  const AiDrawerHeader({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .33.sh,
      child: DrawerHeader(
        child: Row(
          children: [
            const AiProfile(),
            AppSizedBox.sizedBox10W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      AiGradientText(
                        text: l10n.hi,
                        fSize:
                            AppLanguages.isMalayalamLocale(context) ? 18 : 23,
                      ),
                      AppSizedBox.sizedBox5W,
                      const SlideAnimation(
                        child: Text(
                          ' 👋',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  AiGradientText(
                    text: l10n.iAmInaya,
                    fSize: AppLanguages.isMalayalamLocale(context) ? 18 : 23,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
