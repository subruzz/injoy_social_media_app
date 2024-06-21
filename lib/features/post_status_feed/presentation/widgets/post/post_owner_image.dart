import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostOwnerImage extends StatelessWidget {
  const PostOwnerImage({super.key, required this.ownerImage});
  final String? ownerImage;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: ownerImage != null
            ? CachedNetworkImage(
                imageUrl: ownerImage!,
                height: .07.sh,
                width: .15.sw,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/images/profile_icon.png',
                height: .07.sh,
                width: .15.sw,
                fit: BoxFit.cover,
              ));
  }
}
