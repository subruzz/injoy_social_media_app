import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/ai_chat/presentation/pages/ai_chat_page.dart';

import '../../../../core/const/app_info_dialog.dart';
import '../../../premium_subscription/presentation/pages/premium_subscripti_builder.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            if (!context.read<AppUserBloc>().appUser.hasPremium) {
              AppInfoDialog.showInfoDialog(
                  title: 'Premium Feature',
                  subtitle:
                      'Unlock this feature with a premium subscription for an enhanced experience.',
                  context: context,
                  callBack: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PremiumSubscriptiBuilder(),
                        ));
                  },
                  buttonText: 'Get Premium');
              return;
            }
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AiChatPage(),
            ));
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.pink,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.circle,
                color: Colors.white,
                size: 30,
              ),
            ),
          ).animate().then(duration: const Duration(seconds: 4)).rotate(
              begin: 0, end: 2 * pi, duration: const Duration(seconds: 2)),
        ),
        AppSizedBox.sizedBox15H,
        SpeedDial(
          heroTag: 'heroTag1',
          overlayOpacity: .5,
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.circle), label: 'Status', onTap: () {}),
            SpeedDialChild(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MyAppRouteConst.mediaPickerRoute,
                    arguments: {
                      'pickerType': MediaPickerType.post,
                    },
                  );
                },
                child: const Icon(Icons.add_to_photos_sharp),
                label: 'Post'),
          ],
        ),
      ],
    );
  }
}
