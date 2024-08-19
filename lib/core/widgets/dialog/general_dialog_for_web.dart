import 'package:flutter/material.dart';

import '../../const/app_config/web_design_const.dart';

class GeneralDialogForWeb {
  static void showSideDialog(
      {required BuildContext context,
      required Widget child,
      AlignmentGeometry alignment = Alignment.topRight,
      double width = 400}) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      barrierLabel: 'Label',
      pageBuilder: (_, __, ___) {
       
        return Align(
          alignment: alignment,
          child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: borderColor,
                    width: 1,
                  ),
                ),
              ),
              width: width,
              child: child),
        );
      },
    );
  }
}
