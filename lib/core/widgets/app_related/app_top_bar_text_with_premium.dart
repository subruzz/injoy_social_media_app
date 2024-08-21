import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/services/method_channel.dart/restart_app.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/premium_badge.dart';

import '../../utils/responsive/responsive_helper.dart';

class AppTopBarTextWithPremium extends StatelessWidget {
  const AppTopBarTextWithPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: isThatTab
              ? Image.asset(
                  AppAssetsConst.applogo,
                  width: 50,
                  height: 50,
                )
              : Text(
                  'INJOY',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      letterSpacing: 5,
                      fontSize: Responsive.deskTopAndTab(context) ? 28 : 25.sp),
                ),
        ),
        AppSizedBox.sizedBox5W,
        if (context.read<AppUserBloc>().appUser.hasPremium) const PremiumBadge()
      ],
    );
  }
}
