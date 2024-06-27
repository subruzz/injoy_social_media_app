import 'package:flutter/material.dart';

class ProfileUserDetailText extends StatelessWidget {
  const ProfileUserDetailText({super.key, required this.fullName, this.style});
  final String fullName;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(fullName, textAlign: TextAlign.center, style: style);
  }
}
