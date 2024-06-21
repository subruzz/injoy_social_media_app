// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PostOwnerUsername extends StatelessWidget {
  const PostOwnerUsername({
    super.key,
    required this.userName,
  });
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Text('@$userName', style: Theme.of(context).textTheme.labelSmall);
  }
}
