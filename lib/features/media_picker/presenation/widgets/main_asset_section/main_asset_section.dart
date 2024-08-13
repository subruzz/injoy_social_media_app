import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';

class MainAssetSection extends StatelessWidget {
  const MainAssetSection({super.key, required this.mainAsset});
  final ValueNotifier<AssetEntity?> mainAsset;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: .4.sh,
        width: .93.sw,
        child: ValueListenableBuilder(
          valueListenable: mainAsset,
          builder: (context, value, child) {
            return value == null
                ? const Center(
                    child: CircularLoading(),
                  )
                : Center(
                    child: ClipRRect(
                      borderRadius: AppBorderRadius.large,
                      child: AssetEntityImage(
                        value,
                        isOriginal: false,
                        thumbnailSize: const ThumbnailSize.square(500),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
