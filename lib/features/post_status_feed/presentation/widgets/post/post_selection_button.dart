import 'package:flutter/material.dart';

class PostSelectionButton extends StatelessWidget {
  const PostSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return     Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'For you',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // FirebaseAuth.instance.signOut();
                      },
                      child: Text(
                        'Follwing',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              );
  }
}