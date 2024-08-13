import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/assets_bloc/assets_bloc.dart';

class AlbumSelectSection extends StatelessWidget {
  const AlbumSelectSection(
      {super.key, required this.selectedAlbum, required this.isPost});
  final ValueNotifier<AssetPathEntity?> selectedAlbum;
  final bool isPost;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumBloc, AlbumBlocState>(
      builder: (context, state) {
        if (state is AlbumSuccess) {
          final assetState = context.read<AssetsBloc>().state;
          if (assetState is! AssetSuccess) {
            context
                .read<AssetsBloc>()
                .add(GetAssetsEvent(selectedAlbum: state.allAlbums[0]));
          }
          selectedAlbum.value = state.allAlbums[0];
          return ValueListenableBuilder(
            valueListenable: selectedAlbum,
            builder:
                (BuildContext context, AssetPathEntity? value, Widget? child) {
              return Row(
                children: [
                  if (!isPost)
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  if (!isPost) AppSizedBox.sizedBox10W,
                  Padding(
                    padding: AppPadding.onlyLeftMedium,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<AssetPathEntity>(
                        isDense: true,
                        value: value,
                        style: Theme.of(context).textTheme.titleLarge,
                        onChanged: (AssetPathEntity? value) {
                          if (value != null) {
                            context
                                .read<AssetsBloc>()
                                .add(GetAssetsEvent(selectedAlbum: value));
                          }
                          selectedAlbum.value = value;
                        },
                        items: state.allAlbums
                            .map<DropdownMenuItem<AssetPathEntity>>((album) {
                          return DropdownMenuItem(
                              value: album, child: Text(album.name));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        if (state is AssetFailure) {
          return const Center(
            child: Text('error'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      listener: (context, state) {
        if (state is AlbumNoPermission) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
