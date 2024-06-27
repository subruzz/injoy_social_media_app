import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            NotificationCard(
              profileImage:
                  'https://tinypng.com/images/social/website.jpg', // Replace with your image path
              name: 'Mariam',
              action: 'commented on your photo',
              time: '3 minutes ago',
            ),
            SizedBox(height: 20),
            NotificationCard(
              profileImage:
                  'https://tinypng.com/images/social/website.jpg', // Replace with your image path
              name: 'Mariam',
              action: 'liked your photo',
              time: '10 minutes ago',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String action;
  final String time;

  NotificationCard({
    required this.profileImage,
    required this.name,
    required this.action,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppDarkColor().secondaryBackground,
          width: 2.0,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileImage),
            radius: 25.0,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name $action',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 4.0),
              Text(
                time,
                style: TextStyle(
                  color: Colors.red, // Red for time
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
