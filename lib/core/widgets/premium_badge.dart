import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: const BoxDecoration(
        color: Colors.amber, // Premium color
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.star,
        color: Colors.white,
        size: 12.w,
      ),
    );
  }
}
