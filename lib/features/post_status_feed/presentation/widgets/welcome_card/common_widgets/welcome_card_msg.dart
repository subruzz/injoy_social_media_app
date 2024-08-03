import 'package:flutter/material.dart';

import '../../../../../../core/const/app_config/app_sizedbox.dart';

class WelcomeCardMessage extends StatelessWidget {
  const WelcomeCardMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No Posts Yet!', style: Theme.of(context).textTheme.displaySmall),
        AppSizedBox.sizedBox5H,
        Text(
          'Follow friends and discover amazing stories.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
