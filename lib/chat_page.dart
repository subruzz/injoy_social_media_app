import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(text: 'Messages'),
                Tab(text: 'Calls'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  MessageList(),
                  CallList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ChatItem(
          name: 'Kathryn',
          time: 'Hey, how are you',
          isCall: false,
        );
      },
    );
  }
}

class CallList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ChatItem(
          name: 'Kathryn',
          time: '16:47 30 May',
          isCall: true,
        );
      },
    );
  }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String time;
  final bool isCall;

  ChatItem({required this.name, required this.time, required this.isCall});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
