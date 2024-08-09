import 'package:flutter/material.dart';
import 'package:social_media_app/core/animation/animated_text.dart';
import 'package:social_media_app/core/animation/text_wavy_animation.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class TextStatusInputField extends StatefulWidget {
  const TextStatusInputField(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;

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

  // @override
  // void dispose() {
  //   super.dispose();
  //   _focus.removeListener(_onFocusChange);
  //   _focus.dispose();
  // }

  @override
  Widget build(BuildContext context) {
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
        hintText: 'Write your thoughts\nwith others',
        label: showLabel
            ? Center(
                child: AnimatedTextKit(
                    onFinished: removeLabel,
                    totalRepeatCount: 1,
                    repeatForever: false,
                    animatedTexts: [
                    WavyAnimatedText('Write your thought ',
                        textStyle: Theme.of(context).textTheme.displayMedium),
                    WavyAnimatedText('with others',
                        textStyle: Theme.of(context).textTheme.displayMedium)
                  ]))
            : null,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
