import 'package:flutter/material.dart';

class NoPostsMessage extends StatelessWidget {
  final String userName;
  final bool isShorts;
  const NoPostsMessage(
      {super.key, required this.userName, this.isShorts = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                style: Theme.of(context).textTheme.labelMedium,
                children: [
                  TextSpan(
                      text: userName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text:
                        ' hasn\'t shared \nany ${isShorts ? 'Shorts' : 'Posts'} yet.',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
