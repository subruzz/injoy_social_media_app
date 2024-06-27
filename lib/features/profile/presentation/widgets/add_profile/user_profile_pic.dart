import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/edit_profile.dart';

class UserProfilePicSelect extends StatelessWidget {
  const UserProfilePicSelect(
      {super.key,
      required this.selectImageCuit,
      this.userImage,
      this.clearImage});
  final PickSingleImageCubit selectImageCuit;
  final void Function()? clearImage;
  final String? userImage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BlocBuilder<PickSingleImageCubit, PickSingleImageState>(
            bloc: selectImageCuit,
            builder: (context, state) {
              return CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  backgroundImage: state is PickSingleImageSuccess
                      ? FileImage(state.img)
                      : userImage != null
                          ? CachedNetworkImageProvider(userImage!)
                          : const AssetImage('assets/images/profile_icon.png'));
            },
          ),
          Positioned(
            right: 20,
            bottom: 0,
            child: GestureDetector(
                onTap: () {
                  selectImageCuit.pickImage();
                  if (clearImage != null && selectImageCuit.img != null) {
                    clearImage!();
                  }
                },
                child: const EditProfileIcon()),
          ),
        ],
      ),
    );
  }
}
