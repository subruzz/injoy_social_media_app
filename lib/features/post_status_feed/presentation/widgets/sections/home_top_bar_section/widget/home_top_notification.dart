import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/const/app_config/app_padding.dart';
import '../../../../../../../core/const/assets/app_assets.dart';
import '../../../../../../../core/theme/color/app_colors.dart';
import '../../../../../../../core/widgets/app_svg.dart';
import '../../../../../../notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import '../../../../../../notification/presentation/pages/notification_page.dart';

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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ));
                },
                assetPath: AppAssetsConst.noti,
                height: 35,
                width: 35,
              ),
              if (state is NotificationLoaded)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: AppDarkColor().buttonBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                        state.notifications.length > 10
                            ? '10+'
                            : state.notifications.length.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: state.notifications.length > 10 ? 11 : 13,
                            color: AppDarkColor().primaryText,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
