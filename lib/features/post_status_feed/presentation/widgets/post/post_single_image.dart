import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostSingleImage extends StatelessWidget {
  const PostSingleImage({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        imgUrl,
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
