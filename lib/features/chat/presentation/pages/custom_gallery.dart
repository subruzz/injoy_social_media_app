import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_video_widget.dart';

class MediaGalleryView extends StatefulWidget {
  final List<MessageEntity> messages;
  final int initialIndex;

  MediaGalleryView({required this.messages, required this.initialIndex});

  @override
  _MediaGalleryViewState createState() => _MediaGalleryViewState();
}

class _MediaGalleryViewState extends State<MediaGalleryView> {
  late PageController _pageController;
  late List<MessageEntity> _mediaMessages;

  @override
  void initState() {
    super.initState();
    _mediaMessages = widget.messages
        .where((message) =>
            message.messageType == MessageTypeConst.photoMessage ||
            message.messageType == MessageTypeConst.videoMessage)
        .toList();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Gallery"),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _mediaMessages.length,
        itemBuilder: (context, index) {
          final message = _mediaMessages[index];
          return _buildMediaWidget(message);
        },
      ),
    );
  }

  Widget _buildMediaWidget(MessageEntity message) {
    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        return Image.network(message.assetLink!);
      case MessageTypeConst.videoMessage:
        return CachedVideoMessageWidget(url: message.assetLink!
            // autoPlay: widget.initialIndex == _mediaMessages.indexOf(message), // Autoplay for the initial video
            );
      default:
        return SizedBox.shrink(); // Placeholder for other message types
    }
  }
}
