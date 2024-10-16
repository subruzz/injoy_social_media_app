  import 'package:flutter/material.dart';
import 'package:social_media_app/main.dart';

void dismissNoConnectionDialog() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  void showNoConnectionDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false, 
          child: AlertDialog(
            title: const Text('No Connection'),
            content: const Text(
                'You are not connected to the internet.\nPlease connect to the internet to dismiss this dialogue'),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
  }
