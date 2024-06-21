import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.appUserBloc});
  final AppUserBloc appUserBloc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'INJOY',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(letterSpacing: 5),
          ),
          if (appUserBloc.appUser!.profilePic != null)
            CircleAvatar(
                backgroundColor: AppDarkColor().background,
                radius: 23,
                backgroundImage: CachedNetworkImageProvider(
                    appUserBloc.appUser!.profilePic!))
        ],
      ),
    );
  }
}
