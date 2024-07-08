import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class AppInfoDialog {
  static void showInfoDialog(
      {required BuildContext context,
      required VoidCallback callBack,
      double width = double.infinity,
      List<Widget> actions = const [],
      Color? backgroundColor,
      RoundedRectangleBorder? shape,
      String? title,
      String? subtitle,
      String closeText = 'Back',
      required String buttonText}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: AppPadding.extraLarge,
          backgroundColor:
              backgroundColor ?? AppDarkColor().secondaryBackground,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                if (title != null)
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                if (subtitle != null) AppSizedBox.sizedBox10H,
                if (subtitle != null)
                  Text(style: Theme.of(context).textTheme.bodyLarge, subtitle),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                closeText,
                style: TextStyle(color: AppDarkColor().primaryText),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                callBack();
              },
              child: Text(
                buttonText,
              ),
            ),
          ],
        );
      },
    );
  }
}
