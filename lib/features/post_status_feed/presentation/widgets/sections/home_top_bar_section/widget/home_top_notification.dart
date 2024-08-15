import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';

import '../../../../../../../core/const/app_config/app_padding.dart';
import '../../../../../../../core/const/assets/app_assets.dart';
import '../../../../../../../core/theme/color/app_colors.dart';
import '../../../../../../../core/widgets/app_related/app_svg.dart';
import '../../../../../../notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';

class HomeTopNotification extends StatelessWidget {
  const HomeTopNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.onlyRightMedium,
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Stack(
            children: [
              CustomSvgIcon(
                onTap: () {
                  Navigator.pushNamed(
                      context, MyAppRouteConst.notificationPage);
                },
                assetPath: AppAssetsConst.noti,
                height: 35,
                width: 35,
              ),
              if (state is NotificationLoaded && state.notifications.isNotEmpty)
                Positioned(
                  right: 5.w,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: AppDarkColor().buttonBackground,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
