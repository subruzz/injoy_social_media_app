import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.onpressed});
  final void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: FloatingActionButton(
        backgroundColor: AppDarkColor().buttonBackground,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onpressed,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
