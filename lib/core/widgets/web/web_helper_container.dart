import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/web_design_const.dart';

class WebHelperContainerWithBorder extends StatelessWidget {
  const WebHelperContainerWithBorder(
      {super.key, required this.child, this.lessPadding = false});
  final Widget child;
  final bool lessPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: borderColor, width: .034),
        ),
        child: Padding(
          padding: EdgeInsets.all(lessPadding ? 15 : 30.0),
          child: Column(
            children: [
              child,
            ],
          ),
        ));
  }
}
