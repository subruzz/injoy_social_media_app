// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

class UserSocialAttribute extends StatelessWidget {
  const UserSocialAttribute({
    super.key,
    required this.name,
    required this.attribute,
  });
  final String name;
  final Widget attribute;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        attribute,
        CustomText(   text: name),
      ],
    );
  }
}
