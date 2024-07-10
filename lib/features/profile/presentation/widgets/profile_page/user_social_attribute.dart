// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:social_media_app/features/profile/presentation/widgets/profile_page/user_fullname.dart';

class UserSocialAttribute extends StatelessWidget {
  const UserSocialAttribute({
    super.key,
    required this.attribute,
    required this.attributeName,
  });
  final int attribute;
  final String attributeName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileUserDetailText(
          fullName: attribute.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        ProfileUserDetailText(
          fullName: attributeName,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
    
  }
}
