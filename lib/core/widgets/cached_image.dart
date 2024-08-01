import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.img, this.size});
  final String img;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        placeholder: (BuildContext context, String url) => const Center(
          child: CircularLoadingGrey(),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) =>
            Center(
                child: Text('Failed to load Image',
                    style: Theme.of(context).textTheme.bodySmall)),
        imageUrl: img,
        height: size?.sh,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
