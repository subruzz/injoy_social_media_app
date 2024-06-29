// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/image_picker_bloc.dart';

class MediaPicker extends StatefulWidget {
  final int maxCount;
  final RequestType requestType;
  const MediaPicker(this.maxCount, this.requestType, {super.key});

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetEntity> assetList = [];
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    try {
      final albums = await ImagePickerServices().loadAlbums(widget.requestType);

      context.read<ImagePickerBloc>().add(LoadAlbumsEvent(albums: albums));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _loadAssets(AssetPathEntity album) async {
    try {
      final assets = await ImagePickerServices().loadAssets(album);
      context.read<ImagePickerBloc>().add(LoadAssetsEvent(assets: assets));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagepickerBloc = context.read<ImagePickerBloc>();
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        if (state is AlbumsLoadedState) {
          albumList = state.albumList;
          selectedAlbum = albumList[0];
          _loadAssets(selectedAlbum!);
        }
        if (state is AssetsLoadedState) {
          assetList = state.assetList;
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DropdownButton<AssetPathEntity>(
                value: selectedAlbum,
                onChanged: (AssetPathEntity? value) {
                  if (value != null) {
                    imagepickerBloc.add(SelectedAlbumEvent(assetvalue: value));
                    if (state is SelectAlbumState) {
                      selectedAlbum = state.asset;
                    }
                    _loadAssets(value);
                  }
                },
                items:
                    albumList.map<DropdownMenuItem<AssetPathEntity>>((album) {
                  return DropdownMenuItem(
                    value: album,
                    child: FutureBuilder<int>(
                      future: album.assetCountAsync,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          final count = snapshot.data ?? 0;
                          return Text("${album.name}($count)");
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, selectedAssetList);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
          body: assetList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: assetList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    AssetEntity assetEntity = assetList[index];
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: assetWidget(assetEntity),
                    );
                  }),
        );
      },
    );
  }

  Widget assetWidget(AssetEntity assetEntity) =>
      BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(
                    selectedAssetList.contains(assetEntity) == true ? 10 : 0,
                  ),
                  child: AssetEntityImage(
                    assetEntity,
                    isOriginal: false,
                    thumbnailSize: const ThumbnailSize.square(250),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (assetEntity.type == AssetType.video)
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.video_call),
                    ),
                  ),
                ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onLongPress: () {
                      Feedback.wrapForLongPress(() {
                        if (selectedAssetList.contains(assetEntity)) {
                          context
                              .read<ImagePickerBloc>()
                              .add(SelectedAssetEvent(asset: assetEntity));
                          if (state is SelectAssetState) {
                            selectedAssetList.remove(assetEntity);
                          }
                        } else if (selectedAssetList.length < widget.maxCount) {
                          context
                              .read<ImagePickerBloc>()
                              .add(SelectedAssetEvent(asset: assetEntity));
                          if (state is SelectAssetState) {
                            selectedAssetList.add(assetEntity);
                          }
                        }
                      }, context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAssetList.contains(assetEntity) == true
                              ? Colors.blue
                              : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 1.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '${selectedAssetList.indexOf(assetEntity) + 1}',
                            style: TextStyle(
                                color: selectedAssetList.contains(assetEntity)
                                    ? Colors.red
                                    : Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
}

class ImagePickerServices {
  Future loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];

    if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(type: requestType);
    } else {
      PhotoManager.openSetting();
    }
    return albumList;
  }

  Future loadAssets(AssetPathEntity selectedAlbum) async {
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
        start: 0, end: await selectedAlbum.assetCountAsync);
    return assetList;
  }
}
