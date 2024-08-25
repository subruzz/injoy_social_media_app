// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/app_related/open_map.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';

class CustomMapDesign extends StatelessWidget {
  final ExploreLocationSearchEntity loc;
  const CustomMapDesign({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (loc.latitude == null || loc.longitude == null) {
            Messenger.showSnackBar(
                message: 'We are sorry , unable to open map right now !');
            return;
          }
          MapService.openMap(
              latitude: loc.latitude!, longitude: loc.longitude!);
        },
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFF2B2B2B), // Dark background color
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Grid lines
              Positioned.fill(
                child: CustomPaint(
                  painter: GridPainter(),
                ),
              ),
              // Labels (simulating street names)
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Twin Peaks",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  "Noe Valley",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              // Marker
              Positioned(
                top: 50,
                left: 120,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.pink,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    final spacing = 20.0;

    for (double i = 0; i <= size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i <= size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
