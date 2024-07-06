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
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: color, letterSpacing: letterSpacing),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
