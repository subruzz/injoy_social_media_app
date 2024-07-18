import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/presentation/pages/person_chat_page.dart';

import '../../../../../../core/theme/color/app_colors.dart';

class ChatCallItem extends StatelessWidget {
  final String name;
  final String time;
  final bool isCall;

  const ChatCallItem(
      {super.key,
      required this.name,
      required this.time,
      required this.isCall});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        log('taped');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PersonChatPage(),
        ));
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
            'https://images.panda.org/assets/images/pages/welcome/orangutan_1600x1000_279157.jpg'), // Replace with your image
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(color: Colors.grey),
      ),
      trailing: isCall
          ? Icon(Icons.call, color: Colors.white)
          : Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppDarkColor().secondaryPrimaryText),
                  child: const Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text('2'),
                  ),
                ),
                Text(
                  '16:47',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 11),
                )
              ],
            ),
    );
  }
}
