import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';

class CachedImage extends StatefulWidget {
  const CachedImage({super.key, required this.img, this.size, this.fit});
  final String img;
  final double? size;
  final BoxFit? fit;
  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: .1,
      maxScale: 4.0,
      onInteractionEnd: (details) {
        _transformationController.value = Matrix4.identity();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 4/3,
          child: CachedNetworkImage(
              placeholder: (BuildContext context, String url) => const Center(
                    child: CircularLoadingGrey(),
                  ),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  Center(
                      child: Text(l10n!.failedToLoadImage,
                          style: Theme.of(context).textTheme.bodySmall)),
              imageUrl: widget.img,
              // height: widget.size?.sh,
              // width: double.infinity,
              fit: widget.fit ?? BoxFit.cover),
        ),
      ),
    );
  }
}
