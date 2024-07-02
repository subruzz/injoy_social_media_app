import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/post/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/assets_bloc/assets_bloc.dart';

class CustomMediaPickerPage extends StatefulWidget {
  const CustomMediaPickerPage(
      {super.key, required this.alreadySelected, this.isPost = false});
  final List<AssetEntity> alreadySelected;
  final bool isPost;
  @override
  State<CustomMediaPickerPage> createState() => _CustomMediaPickerPageState();
}

class _CustomMediaPickerPageState extends State<CustomMediaPickerPage> {
  @override
  void initState() {
    context.read<PickMultipleImageCubit>().clearImage();

    if (widget.alreadySelected.isNotEmpty) {
      _selectedAssetList.addAll(widget.alreadySelected);
      _isSelectedEmpty.value = true;
    }
    super.initState();
  }

  bool iss = false;
  final List<AssetEntity> _selectedAssetList = [];
  final ValueNotifier<AssetPathEntity?> _selectedAlbum = ValueNotifier(null);
  final ValueNotifier<bool> _isSelectedEmpty = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ValueListenableBuilder(
          valueListenable: _isSelectedEmpty,
          builder: (context, value, child) {
            return value
                ? FloatingActionButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      // context
                      //     .read<PickMultipleImageCubit>()
                      //     .addImages(_selectedAssetList);
                      Navigator.pop(context, _selectedAssetList);
                    },
                    // Display check icon
                    child: Icon(
                      Icons.check_rounded,
                      color: AppDarkColor().iconPrimaryColor,
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        body: Column(
          children: [
            BlocConsumer<AlbumBloc, AlbumBlocState>(
              builder: (context, state) {
                if (state is AlbumSuccess) {
                  context
                      .read<AssetsBloc>()
                      .add(GetAssetsEvent(selectedAlbum: state.allAlbums[0]));
                  _selectedAlbum.value = state.allAlbums[0];
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                      AppSizedBox.sizedBox15W,
                      ValueListenableBuilder(
                        valueListenable: _selectedAlbum,
                        builder: (BuildContext context, AssetPathEntity? value,
                            Widget? child) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<AssetPathEntity>(
                              isDense: true,
                              value: value,
                              style: Theme.of(context).textTheme.titleLarge,
                              onChanged: (AssetPathEntity? value) {
                                if (value != null) {
                                  context.read<AssetsBloc>().add(
                                      GetAssetsEvent(selectedAlbum: value));
                                }
                                _selectedAlbum.value = value;
                              },
                              items: state.allAlbums
                                  .map<DropdownMenuItem<AssetPathEntity>>(
                                      (album) {
                                return DropdownMenuItem(
                                    value: album, child: Text(album.name));
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              listener: (context, state) {},
            ),
            BlocBuilder<AssetsBloc, AssetsState>(
              builder: (context, state) {
                if (state is AssetLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularLoading(),
                    ),
                  );
                }
                if (state is AssetFailure) {
                  return Text(state.error);
                }
                if (state is AssetSuccess) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.assets.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                      ),
                      itemBuilder: (context, index) {
                        return Asset(
                            addToSelected: () {
                              _isSelectedEmpty.value =
                                  _selectedAssetList.isNotEmpty;
                            },
                            assetEntity: state.assets[index],
                            selected: _selectedAssetList);
                      },
                    ),
                  );
                }
                return Text('error occure');
              },
            )
          ],
        ),
      ),
    );
  }
}

class Asset extends StatefulWidget {
  const Asset(
      {super.key,
      required this.addToSelected,
      required this.assetEntity,
      required this.selected});

  final VoidCallback addToSelected;
  final AssetEntity assetEntity;
  final List<AssetEntity> selected;

  @override
  State<Asset> createState() => _AssetState();
}

class _AssetState extends State<Asset> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.selected.contains(widget.assetEntity);
    super.initState();
  }

  void onselect() {
    setState(() {
      if (isSelected) {
        HapticFeedback.vibrate();
        widget.selected.remove(widget.assetEntity);
      } else {
        if (widget.selected.length >= 3) return;
        HapticFeedback.vibrate();
        widget.selected.add(widget.assetEntity);
      }
      isSelected = !isSelected;
    });
    widget.addToSelected();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onselect,
      onTap: onselect,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.black,
                border: Border.all(
                  width: isSelected ? 3 : 1,
                  color: isSelected
                      ? AppDarkColor().iconSecondarycolor
                      : Colors.transparent,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AssetEntityImage(
                  widget.assetEntity,
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(250),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppDarkColor().iconSecondarycolor,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.check, color: Colors.white, size: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
