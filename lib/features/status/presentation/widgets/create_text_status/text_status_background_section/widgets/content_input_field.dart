import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/languages/app_languages.dart';
import 'package:social_media_app/core/extensions/localization.dart';
import 'package:social_media_app/core/widgets/animation/animated_text.dart';
import 'package:social_media_app/core/widgets/animation/text_wavy_animation.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class TextStatusInputField extends StatefulWidget {
  const TextStatusInputField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<TextStatusInputField> createState() => _TextStatusInputFieldState();
}

class _TextStatusInputFieldState extends State<TextStatusInputField> {
  final FocusNode focusNode = FocusNode();
  bool showLabel = true;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (focusNode.hasFocus) {
      removeLabel();
    }
  }

  void removeLabel() {
    setState(() {
      showLabel = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      textAlign: TextAlign.center,
      maxLines: null,
      style: Theme.of(context).textTheme.displayMedium,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold, color: AppDarkColor().primaryText),
        focusedErrorBorder: InputBorder.none,
        filled: false,
        hintText: l10n!.writeYourThought,
        label: showLabel && !AppLanguages.isMalayalamLocale(context)
            ? Center(
                child: AnimatedTextKit(
                    onFinished: removeLabel,
                    totalRepeatCount: 1,
                    repeatForever: false,
                    animatedTexts: [
                    WavyAnimatedText(l10n.writeYourThoughtPart1,
                        textStyle: Theme.of(context).textTheme.displayMedium),
                    WavyAnimatedText(l10n.writeYourThoughtPart2,
                        textStyle: Theme.of(context).textTheme.displayMedium)
                  ]))
            : null,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
