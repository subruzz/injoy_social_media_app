import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';

class PostLocation extends StatefulWidget {
  const PostLocation({super.key, required this.setLocation});
  final Function(UserLocation) setLocation;

  @override
  State<PostLocation> createState() => _PostLocationState();
}

class _PostLocationState extends State<PostLocation> {
  String? _locationName;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined, color: Colors.white),
      title: Text(
        _locationName != null ? _locationName! : 'Location',
        style: TextStyle(
            color: _locationName == null
                ? AppDarkColor().primaryText
                : AppDarkColor().secondaryPrimaryText),
      ),
      trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
      onTap: () async {
        final UserLocation? res = await Navigator.pushNamed(
          context,
          MyAppRouteConst.locationPageRoute,
        ) as UserLocation?;

        log('result of locations is $res');
        if (res != null) {
          setState(() {
            _locationName = res.currentLocation;
            widget.setLocation(res);
          });
        }
      },
    );
  }
}
