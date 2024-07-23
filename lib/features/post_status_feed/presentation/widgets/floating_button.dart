import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';

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
              Navigator.pushNamed(
                context,
                MyAppRouteConst.mediaPickerRoute,
                arguments: {
                  'pickerType': MediaPickerType.post,
                },
              );
            },
            child: const Icon(Icons.add_to_photos_sharp),
            label: 'Post'),
      ],
    );
  }
}
