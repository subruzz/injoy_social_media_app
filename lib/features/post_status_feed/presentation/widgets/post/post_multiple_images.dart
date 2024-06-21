import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostMultipleImages extends StatelessWidget {
  const PostMultipleImages({super.key, required this.postImageUrls});
  final List<String> postImageUrls;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: PageView.builder(
        itemCount: postImageUrls.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  postImageUrls[index],
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 2,
                    left: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            style: const TextStyle(fontSize: 8),
                            '${index + 1}/${postImageUrls.length}'),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
