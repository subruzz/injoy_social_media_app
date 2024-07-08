import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/features/post/presentation/pages/create_post_page.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayOpacity: .5,
      icon: Icons.add,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(child: const Icon(Icons.circle), label: 'Status'),
        SpeedDialChild(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreatePostScreen()));
            },
            child: const Icon(Icons.add_to_photos_sharp),
            label: 'Post'),
      ],
    );
  }
}
