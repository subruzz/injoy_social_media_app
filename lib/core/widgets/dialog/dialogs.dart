import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/dialog/app_info_dialog.dart';

import '../../../features/premium_subscription/presentation/pages/premium_subscripti_builder.dart';

class AppDialogsCommon {
  static void noPremium(BuildContext context) {
    AppInfoDialog.showInfoDialog(
        title: 'Premium Feature',
        subtitle:
            'Unlock this feature with a premium subscription for an enhanced experience.',
        context: context,
        callBack: () {
          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PremiumSubscriptiBuilder(),
              ));
        },
        buttonText: 'Get Premium');
  }
}
