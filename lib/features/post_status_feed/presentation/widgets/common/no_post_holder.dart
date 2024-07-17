import 'package:flutter/material.dart';

class NoPostHolder extends StatelessWidget {
  const NoPostHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'No Posts found \nFollow more users to see their posts here!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
