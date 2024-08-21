import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/cubit/asset_file_cubit.dart';
import 'package:social_media_app/features/media_picker/presenation/pages/crop_image_page.dart';
import 'package:social_media_app/features/media_picker/presenation/widgets/drop_down_album_section/album_select_section.dart';
import 'package:social_media_app/features/media_picker/presenation/widgets/grid_asset_showing_section/grid_asset_section.dart';
import 'package:social_media_app/features/media_picker/presenation/widgets/main_asset_section/main_asset_section.dart';
import 'package:social_media_app/features/media_picker/presenation/widgets/selected_image_only_button.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/post/presentation/pages/create_post_page.dart';
import 'package:social_media_app/features/settings/presentation/pages/chat_wallapaper_preview_page.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/status/presentation/pages/create_mutliple_status_page.dart';

import '../../../../core/const/enums/media_picker_type.dart';
import '../../../../core/widgets/common/overlay_loading_holder.dart';

class CustomMediaPickerPage extends StatefulWidget {
  const CustomMediaPickerPage(
      {super.key, required this.pickerType, this.getMessageCubit});
  // final List<AssetEntity>? alreadySelected;
  final GetMessageState? getMessageCubit;
  final MediaPickerType pickerType;
  @override
  State<CustomMediaPickerPage> createState() => _CustomMediaPickerPageState();
}

class _CustomMediaPickerPageState extends State<CustomMediaPickerPage> {
  @override
  // void initState() {
  //   if (!widget.isPost && widget.alreadySelected!.isNotEmpty) {
  //     _selectedAssetList.addAll(widget.alreadySelected!);
  //     _isSelectedEmpty.value = true;
  //   }
  //   super.initState();
  // }
  void initState() {
    super.initState();
  }

  final List<AssetEntity> _selectedAssetList = [];
  final ValueNotifier<AssetPathEntity?> _selectedAlbum = ValueNotifier(null);
  final ValueNotifier<bool> _isSelectedEmpty = ValueNotifier(false);
  final ValueNotifier<AssetEntity?> _mainAsset = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => serviceLocator<AssetsBloc>()),
          BlocProvider(
              create: (context) => serviceLocator<AlbumBloc>()
                ..add(GetAlbumsEvent(
                    type: widget.pickerType == MediaPickerType.reels
                        ? RequestType.video
                        : widget.pickerType == MediaPickerType.chat ||
                                widget.pickerType == MediaPickerType.status
                            ? RequestType.common
                            : RequestType.image))),
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: widget.pickerType == MediaPickerType.post
                ? AppCustomAppbar(
                    title: l10n!.selectImage,
                    showLeading: true,
                    actions: [
                      if (widget.pickerType == MediaPickerType.post)
                        //next button ----> create post
                        Builder(builder: (context) {
                          return IconButton(
                              onPressed: () {
                                final state = context.read<AssetsBloc>().state;
                                if (state is AssetSuccess &&
                                    _mainAsset.value != null) {
                                  context.read<AssetFileCubit>().assetToFile(
                                      selctedAssets: _selectedAssetList.isEmpty
                                          ? [_mainAsset.value!]
                                          : _selectedAssetList);
                                }
                              },
                              icon: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 40.w,
                                color: AppDarkColor().iconSoftColor,
                              ));
                        }),
                    ],
                  )
                : null,

            //only for status creation
            //only shows when atleast one image is selected
            floatingActionButton: widget.pickerType != MediaPickerType.post
                ? Builder(builder: (context) {
                    return SelectedImageOnlyButton(
                      pickerType: widget.pickerType,
                      onPressed: () {
                        context
                            .read<AssetFileCubit>()
                            .assetToFile(selctedAssets: _selectedAssetList);
                      },
                      isSelectedEmpty: _isSelectedEmpty,
                    );
                  })
                : null,
            body: BlocConsumer<AssetFileCubit, AssetFileState>(
              listener: (context, state) {
                if (state is AssetFileSuccess) {
                  if (widget.pickerType == MediaPickerType.wallapaper) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WallpaperPreviewPage(
                            imageFile: state.selectedImages.selectedFiles.first
                                .selectedFile!)));
                    return;
                  }
                  if (widget.pickerType == MediaPickerType.post) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CropImagePage(
                            selectedImages: state.selectedImages,
                            pickerType: widget.pickerType)));
                  } else if (widget.pickerType == MediaPickerType.reels) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreatePostScreen(
                            isReel: true,
                            selectedImages:
                                state.selectedImages.selectedFiles)));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateMutlipleStatusPage(
                            assets: state.selectedImages.selectedFiles,
                            isChat: widget.pickerType == MediaPickerType.chat,
                            getMessageCubit: widget.getMessageCubit,
                          ),
                        ));
                    // Navigator.pushNamed(
                    //   context,
                    //   MyAppRouteConst.createMultipleStatusRoute,
                    //   arguments: {
                    //     'selectedAssets': state.selectedImages.selectedFiles,
                    //     'isChat': widget.pickerType == MediaPickerType.chat,
                    //   },
                    // );
                  }
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => CropImagePage(
                  //       pickerType: widget.pickerType,
                  //       selectedImages: state.selectedImages),
                  // ));
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //for showing the asset that is selected
                        //only while creating post
                        if (widget.pickerType == MediaPickerType.post)
                          MainAssetSection(mainAsset: _mainAsset),
                        if (widget.pickerType == MediaPickerType.post)
                          AppSizedBox.sizedBox10H,
                        //drop down for displaying and selecting the album available in the device
                        AlbumSelectSection(
                          selectedAlbum: _selectedAlbum,
                          isPost: widget.pickerType == MediaPickerType.post,
                        ),
                        AppSizedBox.sizedBox10H,
                        //shows the assets available in each album
                        GridAssetSection(
                            isSelectedEmpty: _isSelectedEmpty,
                            mainAsset: _mainAsset,
                            mediaPickerType: widget.pickerType,
                            selectedAssetList: _selectedAssetList)
                      ],
                    ),
                    if (state is AssetFileLoading) const OverlayLoadingHolder()
                  ],
                );
              },
            ),
          ),
        ));
  }
}
