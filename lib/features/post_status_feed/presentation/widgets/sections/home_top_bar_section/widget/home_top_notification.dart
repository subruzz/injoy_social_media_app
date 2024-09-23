import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';

import '../../../../../../../core/const/app_config/app_padding.dart';
import '../../../../../../../core/const/assets/app_assets.dart';
import '../../../../../../../core/theme/color/app_colors.dart';
import '../../../../../../../core/utils/di/di.dart';
import '../../../../../../../core/widgets/common/app_svg.dart';
import '../../../../../../../core/widgets/dialog/app_dialogs.dart';
import '../../../../../../notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';

class HomeTopNotification extends StatefulWidget {
  const HomeTopNotification({super.key});

  @override
  State<HomeTopNotification> createState() => _HomeTopNotificationState();
}

class _HomeTopNotificationState extends State<HomeTopNotification> {
  final _notificationCubit = serviceLocator<NotificationCubit>();
  @override
  void dispose() {
    _notificationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.onlyRightMedium,
      child: BlocBuilder(
        bloc: _notificationCubit
          ..getMynotifications(myId: context.read<AppUserBloc>().appUser.id),
        builder: (context, state) {
          return Stack(
            children: [
              CustomSvgIcon(
                onTap: () {
                  Navigator.pushNamed(context, MyAppRouteConst.notificationPage,
                      arguments: {'notificationcubit': _notificationCubit});
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
