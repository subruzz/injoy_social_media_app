import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';

class ChatPhotoWidget extends StatelessWidget {
  const ChatPhotoWidget({super.key, required this.url, this.caption});
  final String url;
  final String? caption;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: AppBorderRadius.medium,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularLoadingGrey(),
          ),
        ),
        if (caption != null)
          Text(caption!,
              style:AppTextTheme.getResponsiveTextTheme(context).labelMedium)
      ],
    );
  }
}
