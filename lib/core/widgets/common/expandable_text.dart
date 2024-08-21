import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final Color? color;
  final Widget? otherW;
  const ExpandableText(
      {super.key,
      this.color,
      this.otherW,
      required this.text,
      required this.trimLines});

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(color: widget.color ?? Colors.blue.withOpacity(.8)),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: AppTextTheme.getResponsiveTextTheme(context)
                .labelSmall
                ?.copyWith(
                    color: AppDarkColor().primaryText.withOpacity(.9),
                    fontWeight: FontWeight.w400),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: AppTextTheme.getResponsiveTextTheme(context)
                .labelSmall
                ?.copyWith(
                    color: AppDarkColor().primaryText.withOpacity(.9),
                    fontWeight: FontWeight.w400),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              softWrap: true,
              overflow: TextOverflow.clip,
              text: textSpan,
            ),
            if (!_readMore && widget.otherW != null) widget.otherW!
          ],
        );
      },
    );
    return result;
  }
}
