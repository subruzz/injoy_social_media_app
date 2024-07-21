import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/assets/presenation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/assets/presenation/pages/crop_image_page.dart';

class SelectedImageOnlyButton extends StatelessWidget {
  const SelectedImageOnlyButton({
    super.key,
    required this.isSelectedEmpty,
    required this.onPressed,
    required this.pickerType,
  });
  final MediaPickerType pickerType;
  final ValueNotifier<bool> isSelectedEmpty;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelectedEmpty,
      builder: (context, value, child) {
        return value
            ? FloatingActionButton(
                heroTag: 1,
                shape: OutlineInputBorder(borderRadius: AppBorderRadius.medium),
                onPressed: onPressed,
                // Display check icon
                child: BlocConsumer<AlbumBloc, AlbumBlocState>(
                  buildWhen: (previous, current) =>
                      current is AssetToFileLoading ||
                      current is AssetToFileSuccess,
                  listenWhen: (previous, current) =>
                      current is AssetToFileLoading ||
                      current is AssetToFileSuccess,
                  listener: (context, state) {
                    if (state is AssetToFileSuccess) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CropImagePage(
                            pickerType: pickerType,
                            selectedImages: state.selectedImages),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return Icon(
                      Icons.check_rounded,
                      color: AppDarkColor().iconPrimaryColor,
                    );
                  },
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
