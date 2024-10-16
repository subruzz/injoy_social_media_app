import 'package:flutter/material.dart';

class ChatCallsTabView extends StatelessWidget {
  const ChatCallsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const  Text('data');
        // return const ChatCallItem(
        //   name: 'Kathryn',
        //   time: '16:47 30 May',
        //   isCall: true,
        // );
      },
    );
  }
}
