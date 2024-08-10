import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app/core/widgets/dialog/app_info_dialog.dart';
import 'package:social_media_app/core/const/enums/location_enum.dart';

void showLocationDialog({
  required BuildContext context,
  required LocationStatus locationStatus,
}) {
  final messages = getLocationDialogMessage(locationStatus);
  bool locationOff = locationStatus == LocationStatus.locationNotEnabled;

  AppInfoDialog.showInfoDialog(
      context: context,
      callBack: locationOff
          ? () {
              Geolocator.openLocationSettings();
            }
          : () {
              openAppSettings();
            },
      title: messages['title']!,
      subtitle: messages['subtitle']!,
      buttonText:
          locationOff ? 'Turn On  \u{2794}' : 'Enable  \u{2794}');
}

Map<String, String> getLocationDialogMessage(LocationStatus locationStatus) {
  switch (locationStatus) {
    case LocationStatus.locationNotEnabled:
      return {
        'title': 'Location Services Disabled',
        'subtitle':
            'Please enable location services to continue using this feature.'
      };
    case LocationStatus.locationPermissionDenied:
      return {
        'title': 'Location Permission Denied',
        'subtitle':
            'Please grant location access in your device settings to continue.'
      };
    case LocationStatus.locationPermissionDeniedForever:
      return {
        'title': 'Location Permission Denied Forever',
        'subtitle':
            'Location permission is permanently denied. Please grant location access in your device settings to continue.'
      };
    default:
      return {
        'title': 'Location Error',
        'subtitle': 'An unknown error occurred. Please try again.'
      };
  }
}
