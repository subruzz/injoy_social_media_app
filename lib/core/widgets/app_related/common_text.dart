import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? color;
  final double? letterSpacing;
  const CustomText(this.text,
      {super.key,
      this.style,
      this.color,
      this.letterSpacing,
      this.overflow,
      this.maxLines,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.labelMedium,
      maxLines: maxLines ?? 2,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
