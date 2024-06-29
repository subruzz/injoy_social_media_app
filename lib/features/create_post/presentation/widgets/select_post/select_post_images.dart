// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:social_media_app/core/const/app_sizedbox.dart';
// import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
// import 'package:social_media_app/features/create_post/presentation/widgets/hashtags/search_hashtag.dart';
// import 'package:social_media_app/features/create_post/presentation/widgets/select_post/page_view.dart';
// import 'package:social_media_app/features/create_post/presentation/widgets/select_post/page_view_indicator.dart';

// class SelectPostImages extends StatelessWidget {
//   const SelectPostImages({
//     super.key,
//     required this.pageController,
//   });
//   final PageController pageController;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PickMultipleImageCubit, PickMultipleImageState>(
//       builder: (context, state) {
//         if (state is PickImageSuccess) {
//           final images = state.images;
//           return SizedBox(
//             height: 0.3.sh,
//             width: double.infinity,
//             child: state.images.length == 1
//                 ? CreatePostImage(
//                     selectedImage: images[0],
//                     onTap: () {
//                       context
//                           .read<PickMultipleImageCubit>()
//                           .removeImage(images[0]);
//                     })
//                 : Column(
//                     children: [
//                       PageViewPosts(
//                         pageController: pageController,
//                         images: images,
//                       ),
//                       AppSizedBox.sizedBox5H,
//                       PageViewIndicator(
//                           pageController: pageController, images: images)
//                     ],
//                   ),
//           );
//         } else {
//           return const SizedBox.shrink();
//         }
//       },
//     );
//   }
// }
