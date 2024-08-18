import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? color;
  final double? letterSpacing;
  const CustomText(
      {super.key,
      this.style,
      this.color,
      required this.text,
      this.letterSpacing,
      this.overflow,
      this.maxLines,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontSize: isThatTabOrDeskTop ? 15 : null),
      maxLines: maxLines ?? 2,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
