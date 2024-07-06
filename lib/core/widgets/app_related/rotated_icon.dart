import 'package:flutter/cupertino.dart';

class RotatedIcon extends StatelessWidget {
  const RotatedIcon({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -45 * (2.4 / 180), // -45 degrees in radians
      child: Icon(icon),
    );
  }
}
