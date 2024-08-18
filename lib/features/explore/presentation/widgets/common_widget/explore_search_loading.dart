import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';

class ExploreSearchLoading extends StatelessWidget {
  const ExploreSearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      padding: AppPadding.medium,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              const CircularLoadingGrey(
                size: 25,
              ),
              AppSizedBox.sizedBox10W,
              const CustomText(text: 'Searching for results..')
            ],
          )),
    );
  }
}
