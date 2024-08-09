import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/common/ai_profile.dart';

import '../../../../../../../core/animation/animations.dart';
import '../../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../common/ai_gradeitn_text.dart';

class AiDrawerHeader extends StatelessWidget {
  const AiDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            height: .33.sh,
            child: DrawerHeader(
              child: Row(
                children: [
                  const AiProfile(),
                  AppSizedBox.sizedBox10W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const AiGradientText(
                            text: "Hi",
                            fSize: 23,
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
                      const AiGradientText(
                        text: "Iam Inaya",
                        fSize: 23,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}