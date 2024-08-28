import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import '../../../../core/services/app_interal/haptic_feedback.dart';
import '../../../../core/utils/rive/rive_helper.dart';
import 'animated_bar.dart';

class BottomBarItems extends StatelessWidget {
  const BottomBarItems(
      {super.key,
      required this.animateToIcon,
      required this.controllers,
      required this.riveIconInputs,
      required this.currentPage});
  final void Function(int index) animateToIcon;
  final List<StateMachineController?> controllers;
  final List<SMIBool> riveIconInputs;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppDarkColor().bottomBarColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppDarkColor().bottomBarLowShade,
            offset: const Offset(0, 20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          RiveHelper.bottomNavItems.length,
          (index) {
            final riveIcon = RiveHelper.bottomNavItems[index];
            return GestureDetector(
              onTap: () {
                HapticFeedbackHelper().vibrate();
                animateToIcon(index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBar(isActive: currentPage == index),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Opacity(
                      opacity: currentPage == index ? 1 : 0.5,
                      child:  RiveAnimation.asset(
                        riveIcon.src,
                        artboard: riveIcon.artboard,
                        onInit: (artboard) {
                          RiveHelper.riveOnInIt(artboard,
                              stateMachineName: riveIcon.stateMachineName,
                              controllers: controllers,
                              riveIconInputs: riveIconInputs);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
