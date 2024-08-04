import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/loading/loading_bar.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_loading.dart';

class OverlayLoadingHolder extends StatelessWidget {
  const OverlayLoadingHolder(
      {super.key,
      this.wantWhiteLoading = false,
      this.wantLoadingGif = false,
      this.wantAnimatedLoading = false});
  final bool wantWhiteLoading;
  final bool wantAnimatedLoading;
  final bool wantLoadingGif;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(.6),
      child: Center(
          child: wantWhiteLoading
              ? const CircularLoading()
              : wantAnimatedLoading
                  ? const LoadingBar()
                  : wantLoadingGif
                      ? const AppLoadingGif()
                      : const CircularLoadingGrey()),
    );
  }
}
