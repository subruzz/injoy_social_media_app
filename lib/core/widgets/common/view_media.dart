import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/cached_image.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/common/page_view.dart';
import 'package:social_media_app/core/widgets/common/page_view_indicator.dart';

class ViewMedia extends StatefulWidget {
  const ViewMedia({
    super.key,
    required this.assets,
    required this.initialIndex,
  });

  final List<String> assets;
  final int initialIndex;

  @override
  State<ViewMedia> createState() => _ViewMediaState();
}

class _ViewMediaState extends State<ViewMedia> {
  late PageController _pageC;
  @override
  void initState() {
    super.initState();
    final safeInitialIndex =
        (widget.initialIndex >= 0 && widget.initialIndex < widget.assets.length)
            ? widget.initialIndex
            : 0;
    _pageC = PageController(initialPage: safeInitialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppCustomAppbar(
        title: l10n!.viewMedia,
        showLeading: true,
      ),
      body: Stack(
        children: [
          CustomPageView(
            pageController: _pageC,
            netImages: widget.assets,
            fit: BoxFit.contain,
          ),
          if (widget.assets.length > 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: AppPadding.onlyBottomLarge,
                child: PageViewIndicator(
                    pageController: _pageC, count: widget.assets.length),
              ),
            )
        ],
      ),
    );
  }
}
