import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/features/assets/presenation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/assets/presenation/widgets/drop_down_album_section/album_select_section.dart';
import 'package:social_media_app/features/assets/presenation/widgets/grid_asset_showing_section/grid_asset_section.dart';
import 'package:social_media_app/features/assets/presenation/widgets/main_asset_section/main_asset_section.dart';
import 'package:social_media_app/features/assets/presenation/widgets/selected_image_only_button.dart';

class CustomMediaPickerPage extends StatefulWidget {
  const CustomMediaPickerPage(
      {super.key, required this.alreadySelected, this.isPost = false});
  final List<AssetEntity>? alreadySelected;
  final bool isPost;
  @override
  State<CustomMediaPickerPage> createState() => _CustomMediaPickerPageState();
}

class _CustomMediaPickerPageState extends State<CustomMediaPickerPage> {
  @override
  void initState() {
    if (!widget.isPost && widget.alreadySelected!.isNotEmpty) {
      _selectedAssetList.addAll(widget.alreadySelected!);
      _isSelectedEmpty.value = true;
    }
    super.initState();
  }

  bool iss = false;
  final List<AssetEntity> _selectedAssetList = [];
  final ValueNotifier<AssetPathEntity?> _selectedAlbum = ValueNotifier(null);
  final ValueNotifier<bool> _isSelectedEmpty = ValueNotifier(false);
  final ValueNotifier<AssetEntity?> _mainAsset = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.isPost
            ? AppCustomAppbar(
                title: const Text('Select Image'),
                showLeading: true,
                actions: [
                  if (widget.isPost)
                    //next button ----> create post
                    IconButton(
                        onPressed: () {
                          final state = context.read<AssetsBloc>().state;
                          if (state is AssetSuccess &&
                              _mainAsset.value != null) {
                            context.pushNamed(MyAppRouteConst.createPostRoute,
                                extra: _selectedAssetList.isEmpty
                                    ? [_mainAsset.value!]
                                    : _selectedAssetList);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_right_alt,
                          size: 40.w,
                          color: AppDarkColor().iconSecondarycolor,
                        ))
                ],
              )
            : null,

        //only for status creation
        //only shows when atleast one image is selected
        floatingActionButton: !widget.isPost
            ? SelectedImageOnlyButton(
                isSelectedEmpty: _isSelectedEmpty,
                buttonPressed: () {
                  log(_selectedAssetList.toString());
                  Navigator.pop(context, _selectedAssetList);
                })
            : null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //for showing the asset that is selected
            //only while creating post
            if (widget.isPost) MainAssetSection(mainAsset: _mainAsset),
            if (widget.isPost) AppSizedBox.sizedBox10H,
            //drop down for displaying and selecting the album available in the device
            AlbumSelectSection(
              selectedAlbum: _selectedAlbum,
              isPost: widget.isPost,
            ),
            AppSizedBox.sizedBox10H,
            //shows the assets available in each album
            GridAssetSection(
                isSelectedEmpty: _isSelectedEmpty,
                mainAsset: _mainAsset,
                isPost: widget.isPost,
                selectedAssetList: _selectedAssetList)
          ],
        ),
      ),
    );
  }
}
