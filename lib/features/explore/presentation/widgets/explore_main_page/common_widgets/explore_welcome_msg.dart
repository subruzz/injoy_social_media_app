import 'package:flutter/material.dart';

import '../../../../../../core/const/app_config/app_sizedbox.dart';

class ExploreWelcomeMsg extends StatelessWidget {
  const ExploreWelcomeMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Suggested Users Found',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            AppSizedBox.sizedBox10H,
            Text(
              'Try adding location or interests so we can connect you with others based on your preference',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
