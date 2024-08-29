import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class WebWidthHelper extends StatelessWidget {
  const WebWidthHelper(
      {super.key,
      this.width = 500,
      this.noWidth = false,
      this.isCentre = true,
      this.btwMobAndTab = false,
      required this.child});
  final double width;
  final Widget child;
  final bool isCentre;
  final bool btwMobAndTab;
  final bool noWidth;
  @override
  Widget build(BuildContext context) {
    return isCentre
        ? Center(
            child: SizedBox(
              width: noWidth
                  ? null
                  : btwMobAndTab
                      ? width
                      : isThatTabOrDeskTop
                          ? width
                          : null,
              child: child,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 100),
            child: SizedBox(
              width: isThatTabOrDeskTop ? width : null,
              child: child,
            ),
          );
  }
}
