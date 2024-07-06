import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/profile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/edit_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.profileImage});
  final String? profileImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
            backgroundColor: Colors.black,
            radius: 55,
            backgroundImage: profileImage != null
                ? NetworkImage(profileImage!)
                : const AssetImage('assets/images/profile_icon.png')),
        Positioned(
          right: 20,
          bottom: 0,
          child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => EditProfilePage(
                //       appUser: context.read<AppUserBloc>().appUser!),
                // ));
              },
              child: const EditProfileIcon()),
        ),
      ],
    );
  }
}
