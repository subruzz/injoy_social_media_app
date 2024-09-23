import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';

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
                        errorBuilder: (context, error, stackTrace) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);

                            Messenger.showSnackBar(
                                message:
                                    'Oops Something went wrong!, please try again!');
                          });
                          return const Center(
                            child: Icon(
                              Icons.dangerous,
                              color: Colors.red,
                            ),
                          );
                        },
                        value,
                        isOriginal: false,
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
