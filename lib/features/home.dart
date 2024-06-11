import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomsCreen extends StatelessWidget {
  const HomsCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.abc))),
    );
  }
}
