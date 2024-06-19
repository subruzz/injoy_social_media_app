import 'dart:io';

import 'package:flutter/material.dart';

class CreatePostSecondPage extends StatelessWidget {
  const CreatePostSecondPage(
      {super.key, required this.description, required this.postImages});
  final List<File?> postImages;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.red,
              ))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
