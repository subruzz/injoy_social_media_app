import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/ai_chat/presentation/widgets/common/ai_profile.dart';

import '../../theme/color/app_colors.dart';

class AppInfoOnlyDialog extends StatelessWidget {
  const AppInfoOnlyDialog(
      {super.key,
      this.pic,
      this.topHead,
      this.title,
      this.subTitle,
      this.buttonText});
  final String? pic;
  final Widget? topHead;
  final String? title;
  final String? subTitle;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: isThatDeskTop
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .3)
          : EdgeInsets.symmetric(horizontal: isThatTab ? 200 : 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: AppPadding.large,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppDarkColor().secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                topHead != null
                    ? topHead!
                    : CircularUserProfile(
                        wantCustomAsset: true,
                        customAsset: pic!,
                      ),
                AppSizedBox.sizedBox15H,
                if (title != null)
                  Text(title!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall),
                AppSizedBox.sizedBox10H,
                if (subTitle != null)
                  Text(
                    subTitle!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                AppSizedBox.sizedBox20H,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                        width: null,
                        onClick: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          buttonText ?? AppLocalizations.of(context)!.ok,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppDarkColor().secondaryBackground,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.red.withOpacity(.9),
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                "Oh Snap!",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
              SizedBox(height: 15),
              Text(
                "Looks like something went wrong while processing your request.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Try again",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
