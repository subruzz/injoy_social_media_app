import 'package:flutter/material.dart';

class NoPostsMessage extends StatelessWidget {
  final String userName;

  const NoPostsMessage({super.key, required this.userName});

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
                    text: ' hasn\'t shared \nany posts yet.',
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
